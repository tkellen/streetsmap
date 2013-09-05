define (require) ->

  Backbone = require('backbone')

  Backbone.Collection.extend

    model: require('cs!app/models/route')

    initialize: (models, app) ->
      @App = app
      @listenTo(@App, 'showAllStops', @showAllStops)
      @listenTo(@App, 'hideAllStops', @hideAllStops)

    showAll: ->
      @forEach (item) -> item.show()

    showAllStops: ->
      @forEach (item) ->
        item.showBusStops() if item.get('visible')

    hideAllStops: ->
      @forEach (item) -> item.hideBusStops()

    getTemplateData: ->
      @toJSON()
