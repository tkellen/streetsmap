define (require) ->

  $ = require('domlib')
  config = require('json!config/streetsmap.json')

  window.mapLoaded = ->
    $(window).trigger('start')

  GMap = {}

  GMap.load = (callback) ->
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = 'http://maps.googleapis.com/maps/api/js?key='+config.apikey+'&sensor=true&callback=mapLoaded'
    document.body.appendChild(script)

  GMap