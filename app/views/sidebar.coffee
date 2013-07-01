define (require) ->

  Backbone = require('backbone')

  Backbone.View.extend

    tagName: 'aside'
    events:
      'change .menuitem': 'routeSwitch'
      'click .route': 'subNav'

    keyCodes: [
      { code: 77, show: true,  hide: true } # m key
      { code: 37, show: false, hide: true } # left arrow
      { code: 39, show: true, hide: false } # right arrow
      { code: 27, show: false, hide: true } # esc key
    ]

    initialize: (app) ->
      @App = app
      @model = new Backbone.Model({
        visible:false
      })
      @collection = @App.Collections.Routes
      @listenTo(@App, 'keydown', @keydown)
      @listenTo(@App, 'toggleMenu', @toggle)
      @listenTo(@model, 'change:visible', @changeVisible)
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

    changeVisible: (model, value) ->
      @render()
      if value then @show() else @hide()

    toggle: ->
      @model.set('visible', !@model.get('visible'))

    show: ->
      @$el.show().animate({marginLeft:0}, 100)
      $('body').animate({marginLeft:325}, 100)

    hide: ->
      @$el.animate({marginLeft:-325}, {duration:100, complete:=>@$el.hide()})
      $('body').animate({marginLeft:0}, 100)

    routeSwitch: (event) ->
      route = $(event.target).closest('.route').data('cid')
      @collection.get(route).toggle()

    subNav: (event) ->
      item = $(event.target)
      if item.hasClass('route')
        item.toggleClass('open')
        @collection.get(item.data('cid')).set('navOn',item.hasClass('open'))

    render: ->
      @$el.html(@App.renderTemplate('sidebar', {routes:@collection.toJSON()}))
      @
