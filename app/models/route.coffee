define (require) ->

  CONFIG = require('cjs!config/app')
  Backbone = require('backbone')

  Backbone.Model.extend

    initialize: ->
      @App = @collection.App
      @set({
        visible: false
        drawn: false
        navOn: false
        relationsMapped: false
        busStopsVisible: false
        url: CONFIG.scheduleLink(@toJSON())
      })
      @listenTo(@App, 'start', => @mapRelations(@App.Collections.Points))

    show: ->
      if !@get('drawn')
        @set('drawn', true)
      @set('visible', true)
      @showTimePoints()
      if @get('busStopsVisible') || @App.Views.Map.instance.getZoom() > 14
        @showBusStops()

    hide: ->
      @set('visible', false)
      @hideTimePoints()
      if @get('busStopsVisible')
        @hideBusStops()

    toggle: ->
      if @get('visible') then @hide() else @show()

    mapRelations: (points) ->
      if !@get('relationsMapped')
        timePoints = @get('timePoints').map (item) =>
          point = points.get(item)
          point.mapRelations(@collection)
          point
        @set('timePoints', new Backbone.Collection(timePoints))

        busStops = @get('busStops').map (item) =>
          point = points.get(item)
          point.mapRelations(@collection)
          point
        @set('busStops', new Backbone.Collection(busStops))
        @set('relationsMapped', true)
      @

    showTimePoints: ->
      @get('timePoints').each (item) -> item.show('asTimePoint')

    hideTimePoints: ->
      @get('timePoints').each (item) -> item.hide('asTimePoint')

    showBusStops: ->
      if !@get('busStopsVisible')
        @set('busStopsVisible', true)
        @get('busStops').each (item) -> item.show('asBusStop')

    hideBusStops: ->
      if @get('busStopsVisible')
        @set('busStopsVisible', false)
        @get('busStops').each (item) -> item.hide('asBusStop')

    pointStopNumber: (point) ->
      @get('timePoints').indexOf(point)+1

    getTemplateData: ->
      @toJSON()
