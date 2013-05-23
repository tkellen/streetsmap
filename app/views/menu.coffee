define (require) ->

  Backbone = require('backbone')

  Backbone.View.extend

    isOpen: false
    keyCodes: [
      { code: 77, open: true, close: true } # m key
      { code: 37, open: false, close: true }, # left arrow
      { code: 39, open: true, close: false }, # right arrow
      { code: 27, open: false, close: true }, # esc key
    ]

    initialize: ->
      $(document).on 'keydown', (e) =>
        for mapping of @keyCodes
          key = @keyCodes[mapping];
          if e.which == key.code
            if key.open && key.close
              @toggle()
            else if !@isOpen && key.open
              @open()
            else if @isOpen && key.close
              @close()
            e.preventDefault()

    open: ->
      if !@isOpen
        @isOpen = true
      @

    close: ->
      if @isOpen
        @isOpen = false
      @

    toggle: ->
      if @isOpen
        @close()
      else
        @open()
      @