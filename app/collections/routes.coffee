define (require) ->

  Backbone = require('backbone')

  Backbone.Collection.extend

    model: require('cs!app/models/route')

    initialize: (models, app) ->
      @App = app

    showAll: ->
      @forEach (item) -> item.show()