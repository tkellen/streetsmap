define (require) ->

  Backbone = require('backbone')
  GMap = require('cs!app/classes/gmap')

  Backbone.Model.extend

    initialize: ->
      @App = @collection.App
      @set('visible', false)
      @set('drawn', false)

    show: ->
      if !@get('drawn')
        @set('instance', GMap.buildMarker(@toJSON()))
      @set('visible', true)
      @get('instance').setMap(@App.map())

    hide: ->
      if @get('visible')
        @set('visible', false)
        @get('instance').setMap(null)
