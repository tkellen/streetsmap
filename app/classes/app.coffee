define (require) ->

  GMap = require('cs!app/classes/gmap')
  _ = require('lodash')
  $ = require('domlib')

  # not assigned to anything because jquery plugins
  # automatically attach to the jquery namespace
  require('hammer')

  App = ->
    # Allow event emitting on the application namespace
    _.extend(@, Backbone.Events)
    @

  App::init = ->
    $(window).on 'resize', =>
      @trigger('resize')

    $(document).on 'keydown', (e) =>
      @trigger('keydown', e.which)

    document.body.addEventListener 'touchmove', (e) ->
      e.preventDefault() if !$(e.target).closest('nav').hasClass('scrollable')

    # load google maps
    GMap.loadAPI(=>@trigger('start'))

  App::renderTemplate = (name, context) ->
    @Templates[name](context)

  App