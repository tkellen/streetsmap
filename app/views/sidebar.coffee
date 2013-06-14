define (require) ->

  Backbone = require('backbone')

  Backbone.View.extend

    tagName: 'aside'
    events:
      'click .menuitem': 'click'

    keyCodes: [
      { code: 77, show: true,  hide: true } # m key
      { code: 37, show: false, hide: true } # left arrow
      { code: 39, show: true, hide: false } # right arrow
      { code: 27, show: false, hide: true } # esc key
    ]

    initialize: (app) ->
      @App = app
      @state = new Backbone.Model({visible:false})
      @collection = @App.Collections.Routes
      @listenTo(@App, 'keydown', @keydown)
      @listenTo(@App, 'toggleMenu', @show)
      @listenTo(@state, 'change:visible', @toggle)
      @listenTo(@collection, 'change', @render)
      @render()
      $('body').prepend(@$el)

    keydown: (code) ->
      visible = @state.get('visible')
      for mapping of @keyCodes
        key = @keyCodes[mapping];
        if code == key.code
          if key.show && key.hide
            visible = !visible
          else if !visible && key.show
            visible = true
          else if visible && key.hide
            visible = false
          @state.set('visible', visible)

    show: ->
      @$el.show().animate({marginLeft:0}, 100)
      $('body').animate({marginLeft:300}, 100)

    hide: ->
      @$el.animate({marginLeft:-300}, {duration:100, complete:=>@$el.hide()})
      $('body').animate({marginLeft:0}, 100)

    toggle: (model, value) ->
      if value then @show() else @hide()

    click: (item) ->
      target = $(item.target)
      id = target.attr('id')
      visible = target.is(':checked')
      @collection.findWhere({abbr:id}).set('visible',visible)

    render: ->
      @$el.html(@App.renderTemplate('sidebar', {routes:@collection.toJSON()}))
      @
