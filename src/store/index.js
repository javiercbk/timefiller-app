import Vue from 'nativescript-vue';
import Vuex from 'vuex';

import user from './modules/user';
import worklogs from './modules/worklogs';

Vue.use(Vuex);

const debug = process.env.NODE_ENV !== 'production';

const store = new Vuex.Store({
  modules: {
    user,
    worklogs
  },
  strict: debug
});

Vue.prototype.$store = store;

module.exports = store;
