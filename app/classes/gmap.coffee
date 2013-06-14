define (require) ->

  $ = require('domlib')
  _ = require('lodash')
  config = require('json!config/streetsmap.json')

  GMap = {}

  GMap.load = (callback) ->
    window.callback = callback
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = 'http://maps.googleapis.com/maps/api/js?key='+config.apikey+'&sensor=true&callback=callback'
    document.body.appendChild(script)

  GMap.buildPath = (points) ->
    _.map points, (point) ->
      new google.maps.LatLng(point[0], point[1])

  GMap.buildPolyline = (options) ->
    options = options or {}
    new google.maps.Polyline(
      path: options.path
      strokeColor: options.color or "#ff0000"
      strokeOpacity: options.opacity or 0.5
      strokeWeight: options.weight or 6
    )

  GMap