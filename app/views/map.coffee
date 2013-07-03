define (require) ->

  config = require('cjs!config/app')
  Backbone = require('backbone')
  GMap = require('cs!app/classes/gmap')

  Backbone.View.extend

    className: 'map'

    initialize: (app) ->
      @App = app
      @Routes = @App.Collections.Routes
      @Points = @App.Collections.Points
      @listenTo(@App, 'start', @insert)
      @listenTo(@App, 'resize', @render)
      @listenTo(@App, 'drawPoint', @drawPoint)
      @listenTo(@App, 'markerClick', @markerClick)
      @listenTo(@Routes, 'change:drawn', @drawRoute)
      @listenTo(@Points, 'change:drawn', @drawMarker)
      @listenTo(@Routes, 'change:visible', @toggleItem)
      @listenTo(@Points, 'change:visible', @toggleItem)

    resize: ->
      h = $(window).height()-45
      w = $(window).width()
      if h != window.height || w != window.width
        @$el.css('height',h)
        @$el.css('width',w)
        window.height = h
        window.width = w

    zoom: ->
      if @instance.getZoom() > 14
        @App.trigger('showAllStops')
      else
        @App.trigger('hideAllStops')

    insert: ->
      @instance = GMap.create(@el, config.map).on('zoom_changed', => @zoom())
      @Routes.showAll()
      # fire this to signal sidebar that it should render.
      # this is necessary because the sidebar state is based
      # on the visibility of routes on the map
      @App.trigger('routesCreated')
      @render()
      $('body').append(@el)

    render: ->
      @resize()
      @

    drawRoute: (model) ->
      # create polyline
      route = GMap.polyline
        path: GMap.path(model.get('polyline'))
        color: model.get('color')
      # assign google maps element for future access
      model.set('el', route)
      model

    drawMarker: (model) ->
      icon = config.map.icon[model.get('icon')]
      marker = GMap.marker
        position: GMap.latLng(model.get('lat'), model.get('lng'))
        icon:
          url: icon.url
          size: new google.maps.Size(icon.size[0], icon.size[1])
          origin: new google.maps.Point(icon.origin[0], icon.origin[1])
          anchor: new google.maps.Point(icon.anchor[0], icon.anchor[1])

      infoWindow = GMap.infoWindow
        content: @App.renderTemplate('infowindow', model.toJSON())

      marker.on('click', => infoWindow.open(@instance,marker))

      model.set('el', marker)
      model

    toggleItem: (model, value) ->
      if value
        model.get('el').setMap(@instance)
      else
        model.get('el').setMap(null)
