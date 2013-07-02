define (require) ->

  Backbone = require('backbone')

  Backbone.View.extend

    tagName: 'aside'
    events:
      'click .toggleRoutes': 'toggleRoutes'
      'change .routeSwitch': 'routeSwitch'
      'click .route': 'subNav'
      'click .menutoggle': 'toggle'

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

      @$el.hammer().on 'swiperight', '.menuitem', (e) ->
        alert(@)

      #@$el.find('.routes').hammer().on 'swiperight', '.routeSwitch', (e) ->
      #  this.prop('checked',true)

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
      if value then @show() else @hide()

    toggle: ->
      @model.set('visible', !@model.get('visible'))

    show: ->
      @render()
      $('body').addClass('sidebarOpen')

    hide: ->
      $('body').removeClass('sidebarOpen')

    routeSwitch: (event) ->
      route = $(event.target).closest('.route').data('cid')
      @collection.get(route).toggle()

    toggleRoutes: (event) ->
      $('.routeSwitch').each (idx, item) ->
        $(item).trigger('click')

    subNav: (event) ->
      item = $(event.target)
      if item.hasClass('route')
        item.toggleClass('open')
        @collection.get(item.data('cid')).set('navOn',item.hasClass('open'))

    render: ->
      @$el.html(@App.renderTemplate('sidebar', {routes:@collection.toJSON()}))
      @
