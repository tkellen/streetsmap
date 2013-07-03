define (require) ->

  config = require('cjs!config/app')
  Backbone = require('backbone')

  Backbone.Model.extend

    initialize: ->
      @set({
        visible: false
        drawn: false
        navOn: false
        relationsMapped: false
        url: config.scheduleLink(@toJSON())
      })

    toggle: ->
      @set('visible', !@get('visible'))

    relate: (points) ->
      if !@get('relationsMapped')
        @set 'timePoints', @get('timePoints').map (item) =>
          point = points.get(item)
          point.relate(@collection)
          point
        @set 'busStops', @get('busStops').map (item) =>
          point = points.get(item)
          point.relate(@collection)
          point
        @set('relationsMapped', true)
      @

    show: ->
      if !@get('drawn')
        @set('drawn', true)
      if !@get('visible')
        @set('visible', true)

    hide: ->
      if @get('visible')
        @set('visible', false)

    showTimePoints: ->
      @get('timePoints').forEach (item) -> item.show()

    hideTimePoints: ->
      @get('timePoints').forEach (item) -> item.hide()

    showStops: ->
      if @get('visible')
        @get('busStops').forEach (item) -> item.show()

    hideStops: ->
      @get('busStops').forEach (item) -> item.hide()