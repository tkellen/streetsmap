define (require) ->

  Backbone = require('backbone')
  iScroll = require('iscroll')

  Backbone.View.extend

    tagName: 'aside'
    events:
      'click .toggleRoutes': 'toggleRoutes'
      'change .routeSwitch': 'routeSwitch'
      'touchstart .routeBtn': 'touchSwitch'
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
      @listenTo(@App, 'routesCreated', @insert)
      @listenTo(@model, 'change:visible', @changeVisible)

    insert: ->
      @render()
      $('body').prepend(@$el)
      @iScroll = new iScroll(@$el.find('#routes').get(0), {
        hScroll: false
        hideScrollbar: false
      })
      # ensure iScroll has correct height continuously
      setInterval((=>@iScroll.refresh()), 250)

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
      $('body').addClass('sidebarOpen')

    hide: ->
      $('body').removeClass('sidebarOpen')

    touchSwitch: (event) ->
      $(event.target).trigger('click')

    routeSwitch: (event) ->
      window.routeSwitch = event
      route = $(event.target).closest('.route').data('cid')
      @collection.get(route).toggle()

    toggleRoutes: (event) ->
      $('.routeSwitch').each (idx, item) ->
        $(item).trigger('click')

    subNav: (event) ->
      # don't toggle subnav when clicking toggle switch

      if !$(event.target).hasClass('routeSwitch') && !$(event.target).hasClass('schedule')
        item = $(event.target)
        route = item.closest('.route')
        route.toggleClass('open')
        @collection.get(route.data('cid')).set('navOn',route.hasClass('open'))

    render: ->
      @$el.html(@App.renderTemplate('sidebar', {routes:@collection.getTemplateData()}))
      @
