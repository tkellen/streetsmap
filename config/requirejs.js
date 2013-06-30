require.config({

  // override data-main from script tag during debug mode
  baseUrl: '/',

  // automatically require on page load in debug mode
  deps: ['cs!app/index'],

  // automatically require this for production build
  insertRequire: ['cs!app/index'],

  // map bower components to nice paths
  paths: {
    domlib: 'components/zepto/zepto',
    lodash: 'components/lodash/lodash',
    backbone: 'components/backbone/backbone',
    handlebars: 'components/handlebars/handlebars',
    text: 'components/requirejs-plugins/lib/text',
    json: 'components/requirejs-plugins/src/json',
    cs: 'components/require-cs/cs',
    hammer: 'components/hammerjs/dist/hammer.js',
    'coffee-script': 'components/coffee-script/index'
  },

  // load non-amd dependencies
  shim: {
    domlib: {
      exports: '$'
    },
    backbone: {
      deps: ['domlib', 'lodash'],
      exports: 'Backbone'
    },
    handlebars: {
      exports: 'Handlebars'
    }
  },

  // modules not included in optimized build
  stubModules: ['cs', 'coffee-script']

});