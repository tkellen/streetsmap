define (require) ->

  $ = require('domlib')
  App = require('cs!app/classes/app')
  Data = require('json!config/mapdata.json')
  Points = require('cs!app/collections/points')
  Routes = require('cs!app/collections/routes')
  Sidebar = require('cs!app/views/sidebar')
  Header = require('cs!app/views/header')
  Map = require('cs!app/views/map')

  StreetsMap = window.App = new App()
  StreetsMap.Templates = require('templates')
  StreetsMap.Collections =
    Points: new Points(Data.Points, StreetsMap)
    Routes: new Routes(Data.Routes, StreetsMap)
  StreetsMap.Views =
    Sidebar: new Sidebar(StreetsMap)
    Header: new Header(StreetsMap)
    Map: new Map(StreetsMap)

  $ ->
    StreetsMap.init()

  StreetsMap
