define (require) ->

  Backbone = require('backbone')

  Backbone.Collection.extend

    model: require('cs!app/models/point')

    initialize: (models, app) ->
      @App = app
      @listenTo(@App, 'showStops', @showStops)
      @listenTo(@App, 'hideStops', @hideStops)

    showStops: ->
      console.log('showing stops')

    hideStops: ->
      console.log('hiding stops')