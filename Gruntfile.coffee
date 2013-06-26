module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig

    stylus:
      css:
        src: 'app/assets/css/style.styl'
        dest: 'dist/style.css'

    copy:
      images:
        expand: true
        cwd: 'app/assets'
        src: 'img/**/*'
        dest: 'dist'

    watch:
      options:
        livereload: true
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
      debug:
        options:
          base: './'
          middleware: (connect, options) ->
            [
              (req, res, next) ->
                if req.url == '/'
                  res.writeHead(302, {Location: 'dist'})
                  res.end()
                else
                  next()
              connect.static(options.base)
              connect.directory(options.base)
            ]
      production:
        options:
          base: 'dist'

    jade:
      debug:
        expand: true
        cwd: 'app/pages'
        src: '*.jade'
        dest: 'dist'
        ext: '.html'
        options:
          data:
            config: require('./config/streetsmap'),
            debug: true
      production:
        expand: true
        cwd: 'app/pages'
        src: '*.jade'
        dest: 'dist'
        ext: '.html'
        options:
          data:
            config: require('./config/streetsmap')
            debug: false

    handlebars:
      templates:
        src: 'app/templates/*.hbs'
        dest: 'dist/templates.js'
        options:
          amd: true,
          processName: (name) ->
            require('path').basename(name, '.hbs')

    requirejs:
      options:
        baseUrl: '',
        mainConfigFile: 'config/requirejs.js',
        name: 'components/almond/almond',
        out: 'dist/streetsmap.js'

      debug:
        options:
          optimize: 'none'
      production:
        options:
          optimize: 'uglify2'

  grunt.registerTask('work', ['jade:debug', 'handlebars', 'stylus', 'connect:debug', 'watch'])
  grunt.registerTask('production', ['jade:production', 'handlebars', 'requirejs:production', 'stylus', 'connect:production:keepalive'])
  grunt.registerTask('default', ['work'])

