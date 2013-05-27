define (require) ->

  $ = require('domlib')
  App = require('cs!app/classes/app')

  StreetsMap = window.App = new App()
  StreetsMap.Templates = require('dist/templates')
  StreetsMap.Data = require('json!config/mapdata.json')
  StreetsMap.Views =
    Menu: require('cs!app/views/menu')
    Map: require('cs!app/views/map')
  StreetsMap.Collections =
    Routes: require('cs!app/collections/routes')
    Points: require('cs!app/collections/routes')

  $ ->
    StreetsMap.init()