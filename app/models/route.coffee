define (require) ->

  config = require('cjs!config/app')
  Backbone = require('backbone')

  Backbone.Model.extend

    initialize: ->
      @App = @collection.App
      @set('visible', false)
      @set('drawn', false)
      @set('navOn', false)
      @set('url', config.scheduleLink(@toJSON()))

    toggle: ->
      @set('visible', !@get('visible'))

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
      @get('busStops').forEach (item) -> item.show()

    hideStops: ->
      @get('busStops').forEach (item) -> item.hide()