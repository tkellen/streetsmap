define (require) ->

  GMap = require('cs!app/classes/gmap')
  $ = require('domlib')
  _ = require('lodash')

  App = ->
    # Allow event emitting on the application namespace
    _.extend(@, Backbone.Events)
    @

  App::init = ->
    $(window).on('resize', => @trigger('resize'))
    $(document).on('keydown', (e) => @trigger('keydown', e.which))

    # load google maps
    GMap.loadAPI(=>@trigger('start'))

  App::renderTemplate = (name, context) ->
    @Templates[name](context)

  App