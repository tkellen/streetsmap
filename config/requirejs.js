require.config({

  // override data-main from script tag during debug mode
  baseUrl: '/',

  // automatically require on page load in debug mode
  deps: ['cs!app/index'],

  // automatically require this for production build
  insertRequire: ['cs!app/index'],

  // map bower components to nice paths
  paths: {
    domlib: 'components/jquery/jquery',
    lodash: 'components/lodash/lodash',
    backbone: 'components/backbone/backbone',
    handlebars: 'components/handlebars/handlebars',
    hammer: 'components/hammerjs/dist/jquery.hammer',
    iscroll: 'components/iscroll/src/iscroll',
    templates: 'public/templates',

    // loader plugins
    'amd-loader': 'components/amd-loader/amd-loader',
    'coffee-script': 'components/coffee-script/index',
    text: 'components/requirejs-plugins/lib/text',
    json: 'components/requirejs-plugins/src/json',
    cjs: 'components/cjs/cjs',
    cs: 'components/require-cs/cs'
  },

  // load non-amd dependencies
  shim: {
    domlib: {
      exports: '$'
    },
    iscroll: {
      exports: 'iScroll'
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
  stubModules: ['amd-loader', 'coffee-script', 'text', 'json', 'cjs', 'cs']

});
