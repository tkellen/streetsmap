define (require) ->

  Backbone = require('backbone')

  Backbone.View.extend

    tagName: 'header'
    events:
      'click .menutoggle': 'toggle'

    initialize: (app) ->
      @App = app
      @render()
      $('body').prepend(@$el)

    toggle: ->
      @App.trigger('toggleMenu')

    render: ->
      @$el.html(@App.renderTemplate('header'))
      @
