define (require) ->

  config = require('json!config/streetsmap.json')
  Backbone = require('backbone')

  Backbone.View.extend

    initialize: ->
      $(window).on('resize', => @resize())
      $(window).on('start', => @insert())
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
      @map = new google.maps.Map @el,
        zoom: config.map.zoom,
        center: new google.maps.LatLng(
          config.map.center.lat,
          config.map.center.lng
        )
        mapTypeId: google.maps.MapTypeId.ROADMAP
        scaleControl: true
      @render()

    render: ->
      @resize()
      @