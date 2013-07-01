module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig

    stylus:
      css:
        src: 'app/assets/css/style.styl'
        dest: 'public/style.css'

    copy:
      images:
        expand: true
        cwd: 'app/assets'
        src: 'img/**/*'
        dest: 'public'

    watch:
      options:
        livereload: true
      app:
        files: ['app/*',
                'app/classes/*',
                'app/models/*',
                'app/views/*',
                'app/collections/*']
      css:
        files: ['app/assets/css/*']
        tasks: ['stylus']
      jade:
        files: ['app/pages/*']
        tasks: ['jade:debug']
      handlebars:
        files: ['app/templates/*']
        tasks: ['handlebars']

    connect:
      options:
        port: 8000
        base: 'public'
      debug:
        options:
          middleware: (connect, options) ->
            [
              # allow requirejs to find deps async
              connect().use('/app',connect.static(__dirname+'/app'))
              connect().use('/config',connect.static(__dirname+'/config'))
              connect().use('/public',connect.static(__dirname+'/public'))
              connect().use('/components',connect.static(__dirname+'/components'))
              connect.static(options.base)
              connect.directory(options.base)
            ]
      production:
        options:
          base: 'public'

    jade:
      debug:
        expand: true
        cwd: 'app/pages'
        src: '*.jade'
        dest: 'public'
        ext: '.html'
        options:
          data:
            config: require('./config/app'),
            debug: true
      production:
        expand: true
        cwd: 'app/pages'
        src: '*.jade'
        dest: 'public'
        ext: '.html'
        options:
          data:
            config: require('./config/app')
            debug: false

    handlebars:
      templates:
        src: 'app/templates/*.hbs'
        dest: 'public/templates.js'
        options:
          amd: true,
          processName: (name) ->
            require('path').basename(name, '.hbs')

    requirejs:
      options:
        baseUrl: '',
        mainConfigFile: 'config/requirejs.js',
        name: 'components/almond/almond',
        out: 'public/streetsmap.js'

      debug:
        options:
          optimize: 'none'
      production:
        options:
          optimize: 'uglify2'

  grunt.registerTask('work', ['jade:debug', 'handlebars', 'stylus', 'connect:debug', 'watch'])
  grunt.registerTask('production', ['jade:production', 'handlebars', 'requirejs:production', 'stylus', 'connect:production:keepalive'])
  grunt.registerTask('noop',->)
  grunt.registerTask('default', ['work'])

