define (require) ->

  config = require('cjs!config/app')
  Backbone = require('backbone')

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
      @instance = new google.maps.Map @el,
        zoom: config.map.zoom,
        center: new google.maps.LatLng(
          config.map.center.lat,
          config.map.center.lng
        )
        keyboardShortcuts: false
        mapTypeId: google.maps.MapTypeId.ROADMAP
        scaleControl: true
      google.maps.event.addListener(@instance, 'zoom_changed', => @zoom())
      @collection.showAll()
      @render()

    render: ->
      @resize()
      @