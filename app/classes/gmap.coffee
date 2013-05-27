define (require) ->

  $ = require('domlib')
  config = require('json!config/streetsmap.json')

  GMap = {}

  GMap.load = (callback) ->
    window.callback = callback
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = 'http://maps.googleapis.com/maps/api/js?key='+config.apikey+'&sensor=true&callback=callback'
    document.body.appendChild(script)

  GMap.buildPolyline = (points) ->
    points.map (point) ->
      new google.maps.LatLng(point[0], point[1])

  GMap.drawPolyline = (options) ->
    options = options or {}
    new google.maps.Polyline(
      path: options.path
      strokeColor: options.color or "#ff0000"
      strokeOpacity: options.opacity or 0.5
      strokeWeight: options.weight or 6
    ).setMap(options.map)

  GMap