define (require) ->

  Backbone = require('backbone')

  Backbone.Collection.extend

    model: require('cs!app/models/point')

    initialize: (models, app) ->
      @App = app