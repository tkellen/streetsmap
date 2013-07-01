define (require) ->

  config = require('cjs!config/app')
  Backbone = require('backbone')
  GMap = require('cs!app/classes/gmap')

  Backbone.Model.extend

    initialize: ->
      @App = @collection.App
      @Points = @App.Collections.Points
      @set('visible', false)
      @set('drawn', false)
      @set('navOn', false)
      @set('url', config.scheduleLink(@toJSON()))
      @on('change:visible', @changeVisible)
      @listenTo(@App, 'showStops', @showStops)
      @listenTo(@App, 'hideStops', @hideStops)

      # map timepoints and bus stops to point models
      @set('timePoints', @get('timePoints').map (item) => @Points.get(item))
      @set('busStops', @get('busStops').map (item) => @Points.get(item))

    changeVisible: (model, value) ->
      if value then @show() else @hide()

    toggle: ->
      @set('visible', !@get('visible'))

    show: ->
      if !@get('drawn')
        @set('instance', GMap.buildPolyline
          path: GMap.buildPath(@get('polyline'))
          color: @get('color')
        )
      @showTimePoints()
      @set('visible', true)
      @set('drawn', true)
      @get('instance').setMap(@App.map())

    hide: ->
      @hideTimePoints()
      @set('visible', false)
      @get('instance').setMap(null)

    showTimePoints: ->
      @get('timePoints').forEach (item) -> item.show()

    hideTimePoints: ->
      @get('timePoints').forEach (item) -> item.show()


    showStops: ->
      @get('busStops').forEach (item) -> item.show()

    hideStops: ->
      @get('busStops').forEach (item) -> item.hide()