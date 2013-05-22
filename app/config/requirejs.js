require.config({

  // only used in debug mode
  baseUrl: '/app',

  deps: ['cs!index'],

  paths: {
    domlib: '../components/zepto/zepto',
    lodash: '../components/lodash/lodash',
    backbone: '../components/backbone/backbone',
    text: '../components/requirejs-plugins/lib/text',
    json: '../components/requirejs-plugins/src/json',
    cs: '../components/require-cs/cs',
    'coffee-script': '../components/coffee-script/index'
  },

  // dependency management
  shim: {
    domlib: {
      exports: '$'
    },
    backbone: {
      deps: ['lodash', 'domlib'],
      exports: 'Backbone',
    },
  },

  // modules not included in compiled output
  stubModules: ['cs', 'coffee-script']

});