define (require) ->

  $ = require('domlib')
  App = require('cs!app/classes/app')

  StreetsMap = window.App = new App()
  StreetsMap.Templates = require('templates')
  StreetsMap.Data = require('json!config/mapdata.json')
  StreetsMap.Collections =
    Points: require('cs!app/collections/points')
    Routes: require('cs!app/collections/routes')
  StreetsMap.Views =
    Sidebar: require('cs!app/views/sidebar')
    Header: require('cs!app/views/header')
    Map: require('cs!app/views/map')

  $ ->
    StreetsMap.init()

  StreetsMap
