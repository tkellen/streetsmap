define (require) ->

  config = require('cjs!config/app')
  Backbone = require('backbone')
  GMap = require('cs!app/classes/gmap')

  Backbone.Model.extend

    initialize: ->
      @set('routeOn', false)
      @set('navOn', false)
      @set('drawn', false)
      @set('url', config.scheduleLink(@toJSON()))
      @on('change:routeVisible', -> if value then @show() else @hide())

    toggle: ->
      @set('visible', !@get('visible'))

    show: ->
      if !@get('drawn')
        @set('instance', GMap.buildPolyline
          path: GMap.buildPath(@get('polyline'))
          color: @get('color')
        )
      @set('routeOn', true)
      @set('drawn', true)
      @get('instance').setMap(@collection.App.map())

    hide: ->
      @set('routeOn', false)
      @get('instance').setMap(null)