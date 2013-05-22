require.config({

  // only used in debug mode
  baseUrl: '/app',

  deps: ['cs!index'],

  paths: {
    'jquery': '../components/jquery/jquery',
    'lodash': '../components/lodash/lodash',
    'backbone': '../components/backbone/backbone',
    'coffee-script': '../components/coffee-script/index',
    'text': '../components/requirejs-plugins/lib/text',
    'cs': '../components/require-cs/cs'
  },

  // dependency management
  shim: {
    'backbone': {
      deps: ['lodash', 'jquery'],
      exports: 'Backbone',
    },
  },

  // modules not included in compiled output
  stubModules: ['cs', 'coffee-script']

});