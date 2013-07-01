define (require) ->

  $ = require('domlib')
  config = require('cjs!config/app')
  _ = require('lodash')

  GMap = {}

  GMap.load = (callback) ->
    window.callback = callback
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = 'http://maps.googleapis.com/maps/api/js?key='+config.apikey+'&sensor=true&callback=callback'
    document.body.appendChild(script)

  GMap.buildMap = (element, options) ->
    options.center = new google.maps.LatLng(
      options.center.lat
      options.center.lng
    )
    map = new google.maps.Map(element, options)
    # add convienence methods for adding and removing listeners
    map.on = (event, method) ->
      google.maps.event.addListener(@, event, method)
      @
    map.off = (event, method) ->
      google.maps.event.removeListener(@, event, method)
      @
    map

  GMap.buildPath = (points) ->
    points.map (point) ->
      new google.maps.LatLng(point[0], point[1])

  GMap.buildPolyline = (options) ->
    options = options or {}
    new google.maps.Polyline(
      path: options.path
      strokeColor: options.color or "#ff0000"
      strokeOpacity: options.opacity or 0.5
      strokeWeight: options.weight or 6
    )

  GMap.buildMarker = (options) ->
    options = options or {}
    new google.maps.Marker({
      position: new google.maps.LatLng(options.lat, options.lng)
    });

  GMap