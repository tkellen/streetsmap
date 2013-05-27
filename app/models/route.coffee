define (require) ->

  Backbone = require('backbone')
  GMap = require('cs!app/classes/gmap')

  Backbone.Model.extend

    isVisible: false,

    initialize: ->
      @listenTo(@collection.App, 'toggleRoute', @toggle)

    draw: ->
      @set('visible', true)
      @set('instance', GMap.drawPolyline
        path: GMap.buildPolyline(@get('polyline'))
        color: @get('color')
      )

    show: ->
      @get('instance').setMap(@collection.App.map())

    hide: ->
      @get('instance').setMap(null)