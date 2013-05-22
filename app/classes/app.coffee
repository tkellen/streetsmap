define (require) ->

  $ = require('jquery')
  _ = require('lodash')

  App = (map) ->
    @map = map
    @

  App.prototype.start = ->
    # trigger an event (resized) after resizing is complete.  this gives
    # elements that need to know the window size something to listen for
    # to repaint themselves (otherwise they would be resizing continuously
    # as the browser window is resized).
    debounce = _.debounce((-> $(window).trigger('resized')), 500)

    # create a function that will flag screen as disabled if resize event
    # is called more than 3 times.  this prevents what seems like a weird
    # fade to disabled state when the window resize is very short
    disable_after_create = -> _.after(3, (-> $('body').addClass('disabled')))
    disable_after = false

    $(window).on 'resize', =>
      disable_after = disable_after_create() if !disable_after
      debounce()
      disable_after()

    $(window).on 'resized', =>
      $('body').removeClass('disabled')
      disable_after = false;

    if @map
      @map.insert()

  App