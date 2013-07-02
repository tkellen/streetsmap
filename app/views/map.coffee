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
      @listenTo(@Routes, 'change:visible', @toggleElement)
      @listenTo(@Points, 'change:drawn', @drawMarker)
      @listenTo(@Points, 'change:visible', @toggleElement)


    resize: ->
      h = $(window).height()-45
      w = $(window).width()
      if h != window.height || w != window.width
        @$el.css('height',h)
        @$el.css('width',w)
        window.height = h
        window.width = w

    zoom: ->
      if @instance.getZoom() > 13
        @App.trigger('showAllStops')
      else
        @App.trigger('hideAllStops')

    insert: ->
      @instance = GMap.create(@el, config.map).on('zoom_changed', => @zoom())
      @Routes.showAll()
      @render()
      $('body').append(@el)

    render: ->
      @resize()
      @

    drawRoute: (model) ->
      # map point IDs to point models
      model.set('timePoints', model.get('timePoints').map (item) => @Points.get(item))
      model.set('busStops', model.get('busStops').map (item) => @Points.get(item))
      # create polyline
      route = GMap.polyline
        path: GMap.path(model.get('polyline'))
        color: model.get('color')
      # assign google maps element for future access
      model.set('el', route)
      # show timepoints only
      model.showTimePoints()
      model

    drawMarker: (model) ->
      # create marker
      marker = GMap.marker
        position: GMap.latLng(model.get('lat'), model.get('lng'))
      # assign google maps element for future access
      model.set('el', marker)
      model

    toggleElement: (model, value) ->
      if value
        model.get('el').setMap(@instance)
      else
        model.get('el').setMap(null)