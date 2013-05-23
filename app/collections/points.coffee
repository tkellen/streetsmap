define (require) ->

  Backbone = require('backbone')

  Backbone.Collection.extend
    model: require('cs!models/point')