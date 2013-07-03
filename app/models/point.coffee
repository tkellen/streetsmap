define (require) ->

  Backbone = require('backbone')

  Backbone.Model.extend

    initialize: ->
      @set({
        visible: false
        drawn: false
        relationsMapped: false
        type: false
      })

    relate: (routes) ->
      if !@get('relationsMapped')
        @set 'usedBy', @get('usedBy').map (route) =>
          routes.get(route)
        @set('relationsMapped', true)
      @

    show: ->
      if !@get('drawn')
        @set('drawn', true)
      if !@get('visible')
        @set('visible', true)

    hide: ->
      if @get('visible')
        @set('visible', false)