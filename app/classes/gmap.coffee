define (require) ->

  $ = require('domlib')
  config = require('cjs!config/app')
  _ = require('lodash')

  GMap = {}

  GMap.loadAPI = (callback) ->
    window.__callback = callback
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = 'http://maps.googleapis.com/maps/api/js?key='+config.apikey+'&sensor=true&callback=__callback'
    document.body.appendChild(script)

  GMap.addEventMethods = (element) ->
    element.on = (event, method) ->
      google.maps.event.addListener(element, event, method)
      element
    element.off = (event, method) ->
      google.maps.event.removeListener(element, event, method)
      element
    element

  GMap.create = (element, options) ->
    options.center = new google.maps.LatLng(
      options.center.lat
      options.center.lng
    )
    map = new google.maps.Map(element, options)
    @addEventMethods(map)

  GMap.path = (points) ->
    points.map (point) ->
      new google.maps.LatLng(point[0], point[1])

  GMap.polyline = (options) ->
    options = options or {}
    new google.maps.Polyline(
      path: options.path
      strokeColor: options.color or config.map.polyline.strokeColor
      strokeOpacity: options.opacity or config.map.polyline.opacity
      strokeWeight: options.weight or config.map.polyline.weight
    )

  GMap.latLng = (lat, lng) ->
    new google.maps.LatLng(lat, lng)

  GMap.marker = (options) ->
    options = options or {}
    marker = new google.maps.Marker(options)
    @addEventMethods(marker)

  GMap.infoWindow = (options) ->
    new google.maps.InfoWindow(options)

  GMap