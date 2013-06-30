define (require) ->

  Backbone = require('backbone')

  Backbone.View.extend

    tagName: 'aside'
    events:
      'change .menuitem': 'routeSwitch'
      'click .schedule': 'routeSchedule'

    keyCodes: [
      { code: 77, show: true,  hide: true } # m key
      { code: 37, show: false, hide: true } # left arrow
      { code: 39, show: true, hide: false } # right arrow
      { code: 27, show: false, hide: true } # esc key
    ]

    initialize: (app) ->
      @App = app
      @model = new Backbone.Model({visible:false})
      @collection = @App.Collections.Routes
      @listenTo(@App, 'keydown', @keydown)
      @listenTo(@App, 'toggleMenu', @toggle)
      @listenTo(@model, 'change:visible', @toggleEvent)
      @listenTo(@collection, 'change', @render)
      @render()
      $('body').prepend(@$el)

    keydown: (code) ->
      visible = @model.get('visible')
      for mapping of @keyCodes
        key = @keyCodes[mapping];
        if code == key.code
          if key.show && key.hide
            visible = !visible
          else if !visible && key.show
            visible = true
          else if visible && key.hide
            visible = false
          @model.set('visible', visible)

    show: ->
      @$el.show().animate({marginLeft:0}, 100)
      $('body').animate({marginLeft:325}, 100)

    hide: ->
      @$el.animate({marginLeft:-325}, {duration:100, complete:=>@$el.hide()})
      $('body').animate({marginLeft:0}, 100)

    toggle: ->
      @model.set('visible', !@model.get('visible'))

    toggleEvent: (model, value) ->
      if value then @show() else @hide()

    routeSwitch: (item) ->
      target = $(item.target)
      id = target.attr('id')
      @collection.findWhere({abbr:id}).toggle()

    routeSchedule: (item) ->
      window.open(item.href)
      return false

    render: ->
      @$el.html(@App.renderTemplate('sidebar', {routes:@collection.toJSON()}))
      @
