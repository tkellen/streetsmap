module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig

    stylus:
      css:
        src: 'app/styles/style.styl'
        dest: 'public/style.css'

    copy:
      assets:
        expand: true
        src: 'assets/**/*'
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
        files: ['app/styles/*']
        tasks: ['stylus']
      jade:
        files: ['app/pages/*']
        tasks: ['jade:debug']
      handlebars:
        files: ['app/templates/*']
        tasks: ['handlebars']

    clean:
      assets: ['public/assets']

    connect:
      options:
        hostname: '*'
        port: 8000
        base: 'public'
      debug:
        options:
          middleware: (connect, options) ->
            [
              # allow requirejs to find deps async
              connect().use('/app',connect.static(__dirname+'/app'))
              connect().use('/config',connect.static(__dirname+'/config'))
              connect().use('/components',connect.static(__dirname+'/components'))
              connect().use('/public',connect.static(__dirname+'/public'))
              # allow assets to be used without copying
              connect().use('/assets',connect.static(__dirname+'/assets'))
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
            CONFIG: require('./config/app'),
            debug: true
      production:
        expand: true
        cwd: 'app/pages'
        src: '*.jade'
        dest: 'public'
        ext: '.html'
        options:
          data:
            CONFIG: require('./config/app')
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
  grunt.registerTask('production', ['clean', 'copy', 'jade:production', 'handlebars', 'requirejs:production', 'stylus', 'connect:production:keepalive'])
  grunt.registerTask('default', ['work'])

