define (require) ->

  config = require('json!config/streetsmap.json')
  Backbone = require('backbone')

  Backbone.View.extend

    className: 'map'

    initialize: (app) ->
      @App = app
      @listenTo(@App, 'resize', @render)
      @listenTo(@App, 'start', @insert)
      $('body').append(@el)

    resize: ->
      h = $(window).height()
      w = $(window).width()
      if h != window.height || w != window.width
        @$el.css('height',h)
        @$el.css('width',w)
        window.height = h
        window.width = w

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
      @render()

    render: ->
      @resize()
      @