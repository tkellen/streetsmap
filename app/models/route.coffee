define (require) ->

  Backbone = require('backbone')
  GMap = require('cs!app/classes/gmap')

  Backbone.Model.extend

    initialize: ->
      @set('visible', false)
      @set('drawn', false)
      @on('change:visible', @toggleEvent)

    show: ->
      if !@get('drawn')
        @set('instance', GMap.buildPolyline
          path: GMap.buildPath(@get('polyline'))
          color: @get('color')
        )
      @set('visible', true)
      @set('drawn', true)
      @get('instance').setMap(@collection.App.map())

    hide: ->
      @set('visible', false)
      @get('instance').setMap(null)

    toggle: ->
      @set('visible', !@get('visible'))

    toggleEvent: (model, value) ->
      if value then @show() else @hide()