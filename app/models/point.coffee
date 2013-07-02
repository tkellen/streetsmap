define (require) ->

  Backbone = require('backbone')

  Backbone.Model.extend

    initialize: ->
      @App = @collection.App
      @set('visible', false)
      @set('drawn', false)

    show: ->
      if !@get('drawn')
        @set('drawn', true)
      if !@get('visible')
        @set('visible', true)

    hide: ->
      if @get('visible')
        @set('visible', false)