define (require) ->

  Backbone = require('backbone')

  Backbone.Collection.extend
    model: require('cs!models/route')

    drawAll: ->
      @forEach (item) ->
        console.log(item)