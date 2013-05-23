define (require) ->

  $ = require('domlib')
  Data = require('json!config/mapdata.json')
  Routes = require('cs!collections/routes')
  Points = require('cs!collections/points')
  MapView = require('cs!views/map')
  StreetsMap = require('cs!classes/app')

  $ ->
    StreetsMap = window.App = new StreetsMap()
    StreetsMap.Map = new MapView()
    StreetsMap.Data = Data
    StreetsMap.Collections =
      Routes: new Routes(Data.routes)
      Points: new Points(Data.points)
    StreetsMap.start()