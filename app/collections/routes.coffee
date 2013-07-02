define (require) ->

  Backbone = require('backbone')

  Backbone.Collection.extend

    model: require('cs!app/models/route')

    initialize: (models, app) ->
      @App = app
      @listenTo(@App, 'showStops', @showStops)
      @listenTo(@App, 'hideStops', @hideStops)

    showAll: ->
      @forEach (item) -> item.show()