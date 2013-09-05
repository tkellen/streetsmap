define (require) ->

  _ = require('lodash')
  Util = {}

  Util.lumosity = (hex) ->
    result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    if result
      rgb = [parseInt(result[1], 16),
             parseInt(result[2], 16),
             parseInt(result[3], 16)]
      lum = (_.max(rgb) + _.min(rgb)) / 510.0
      if lum < 0.45
        "white"
      else
        "black"

  Util
