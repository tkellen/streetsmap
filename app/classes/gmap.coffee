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

  GMap.create = (element, options) ->
    options.center = new google.maps.LatLng(
      options.center.lat
      options.center.lng
    )
    map = new google.maps.Map(element, options)
    map.on = (event, method) ->
      google.maps.event.addListener(map, event, method)
      map
    map

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
    marker.on = (event, method) ->
      google.maps.event.addListener(marker, event, method)
      marker
    marker

  GMap.infoWindow = (options) ->
    options = options or {}
    new google.maps.InfoWindow(options)

  GMap
