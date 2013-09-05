define (require) ->

  Backbone = require('backbone')
  Handlebars = require('handlebars')
  Util = require('cs!app/classes/util')

  Backbone.Model.extend

    initialize: ->
      @App = @collection.App
      @set({
        relationsMapped: false # have we mapped the usedBy field to route models?
        drawn: false # does this have a google maps element yet?
        visible: false # is this point visible on the map?
        visibleCount: 0 # how many routes this point visible for?
        asBusStop: 0 # how many routes is this point visible as a busStop for?
        asTimePoint: 0 # how many routes is this point visible as a timePoint for?
        icon: null
      })

    # because time points and bus stops are shared across multiple routes,
    # we must maintain a count of how many routes it is currently visible
    # for.  without this, turning off a route might hide a time point or
    # bus stop that is used by another.
    visibleAs: (type, increment) ->
      @set(type, @get(type)+increment)
      asTimePoint = @get('asTimePoint')
      asBusStop = @get('asBusStop')
      @set('icon', if asTimePoint >= asBusStop then 'timePoint' else 'busStop')
      visibleCount = asTimePoint+asBusStop
      @set('visibleCount', visibleCount)
      visibleCount

    show: (type) ->
      if !type
        throw new Error('Type must be specified (asBusStop or asTimePoint).')
      @visibleAs(type, 1)
      if !@get('drawn')
        @set('drawn', true)
      @set('visible', true)

    hide: (type) ->
      if !type
        throw new Error('Type must be specified (asBusStop or asTimePoint).')
      visibleCount = @visibleAs(type, -1)
      if visibleCount == 0
        @set('visible', false)

    mapRelations: (routes) ->
      if !@get('relationsMapped')
        usedBy = @get('usedBy').map (idx) =>
          routes.at(idx)
        @set('usedBy', new Backbone.Collection(usedBy))
        @set('relationsMapped', true)
      @

    getTemplateData: ->
      {
        cid: @cid
        name: @get('name')
        usedBy: @get('usedBy').map (route) =>
          {
            name: route.get('name')
            background: route.get('color')
            foreground: Util.lumosity(route.get('color'))
            url: route.get('url')
            stopNumber: route.pointStopNumber(@)
          }
      }
