define (require) ->

  config = require('json!config/streetsmap.json')
  $ = require('jquery')
  App = require('cs!classes/app')
  Map = require('cs!views/map')

  $ ->
    window.App = new App(new Map())

    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = 'http://maps.googleapis.com/maps/api/js?key='+config.apikey+'&sensor=true&callback=App.start'
    document.body.appendChild(script)
