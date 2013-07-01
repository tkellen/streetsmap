define (require) ->

  config = require('cjs!config/app')
  Backbone = require('backbone')
  GMap = require('cs!app/classes/gmap')

  Backbone.View.extend

    className: 'map'

    initialize: (app) ->
      @App = app
      @collection = @App.Collections.Routes
      @marginTop = @$el.css('marginTop')
      @listenTo(@App, 'start', @insert)
      @listenTo(@App, 'resize', @render)
      $('body').append(@el)

    resize: ->
      h = $(window).height()-@marginTop
      w = $(window).width()
      if h != window.height || w != window.width
        @$el.css('height',h)
        @$el.css('width',w)
        window.height = h
        window.width = w

    zoom: ->
      if @instance.getZoom() > 13
        @App.trigger('showStops')
      else
        @App.trigger('hideStops')

    insert: ->
      @instance = GMap.buildMap(@el, config.map).on('zoom_changed', => @zoom())
      @collection.showAll()
      @render()

    render: ->
      @resize()
      @