module.exports = (grunt) ->

  require('time-grunt')(grunt)
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    paths: grunt.file.readJSON 'config/paths.json'

    imagemin:
      dist:
        options:
          optimizationLevel: 7
        files: [
          expand: true
          src: ['<%= paths.images %>/**/*']
        ]

    jshint:
      options:
        curly: true
        eqeqeq: true
        eqnull: true
        browser: true
        globals:
          jQuery: true
      files:
        src: [
          '<%= paths.js.app %>/app-dev.js'
          '<%= paths.js.modules %>/*.js'
          '<%= paths.js.modules %>/*/**.js'
          '!<%= paths.js.modules %>/template/template.js'
        ]

    less:
      options:
        compress: true
        yuicompress: true
      app:
        options:
          sourceMap: true
          sourceMapFilename: '<%= paths.css %>/app.css.map'
        src: '<%= paths.less %>/app.less'
        dest: '<%= paths.css %>/app.css'
      ie:
        files:
          '<%= paths.css %>/ie6.css': ['<%= paths.less %>/ie6.less'],
          '<%= paths.css %>/ie7.css': ['<%= paths.less %>/ie7.less'],
          '<%= paths.css %>/ie8.css': ['<%= paths.less %>/ie8.less']

    recess:
      options:
        compile: false
        noIDs: false
        noJSPrefix: false
        noUniversalSelectors: false
      files:
          src: ['<%= paths.css %>/app.css']

  grunt.registerTask 'default', ['less', 'recess', 'jshint', 'imagemin']


