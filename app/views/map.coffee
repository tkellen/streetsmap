define (require) ->

  Backbone = require('backbone')

  Backbone.View.extend

    initialize: ->
      $(window).on('resize', => @resize())

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
        zoom: 13
        scrollwheel: false
        mapTypeId: google.maps.MapTypeId.ROADMAP
        navigationControl: true
        navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL}
        scaleControl: true
        center: new google.maps.LatLng(45.5600,-94.1576)
      @render()

    render: ->
      $('body').append(@el)
      @resize()
      @