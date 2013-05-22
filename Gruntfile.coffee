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
        files: ['app/assets/css/**/*']
        tasks: ['stylus']
      jade:
        files: ['app/**/*', '!app/assets/css/**/*']
        tasks: ['jade:debug']

    connect:
      options:
        port: 8000
      debug:
        options:
          base: ''
      production:
        options:
          base: 'dist'

    jade:
      debug:
        src: 'app/templates/index.jade'
        dest: 'dist/index.html'
        options:
          data:
            config: require('./app/config/streetsmap'),
            debug: true
      production:
        src: 'app/templates/index.jade'
        dest: 'dist/index.html'
        options:
          keepalive: true
          data:
            config: require('./app/config/streetsmap')
            debug: false

    requirejs:
      options:
        mainConfigFile: 'app/config/requirejs.js',
        baseUrl: 'app',
        name: '../components/almond/almond',
        wrap: false
        insertRequire: ['cs!index']
        out: 'dist/streetsmap.js'

      debug:
        options:
          optimize: 'none'
      production:
        options:
          optimize: 'uglify2'

  grunt.registerTask('work', ['jade:debug', 'stylus', 'connect:debug', 'watch'])
  grunt.registerTask('production', ['jade:production', 'requirejs:production', 'stylus', 'connect:production:keepalive'])
  grunt.registerTask('default', ['work'])

