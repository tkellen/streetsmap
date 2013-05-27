define (require) ->

  GMap = require('cs!app/classes/gmap')
  $ = require('domlib')

  App = ->
     _.extend(@, Backbone.Events)
     @

  App::init = ->

    $(window).on('resize', => @trigger('resize'))
    $(document).on('keydown', (e) => @trigger('keydown', e.which))

    # setup collections
    for name, collection of @Collections
      # ugly tight coupling here, but whatever
      @Collections[name] = new collection(@Data[name], @)

    # setup views
    for name, view of @Views
      @Views[name] = new view(@)

    # load google maps
    GMap.load(=>@trigger('start'))

  App::map = ->
    @Views.Map.instance

  App::renderTemplate = (name, context) ->
    @Templates[name](context)

  App