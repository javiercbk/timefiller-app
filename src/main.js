import Vue from 'nativescript-vue';

import router from './router';

import store from './store';

import './styles.scss';

// Uncommment the following to see NativeScript-Vue output logs
Vue.config.silent = false;

router.beforeEach((to, from, next) => {
  const isConfigured = store.getters['user/isConfigured'];
  if (isConfigured || to.name.indexOf('config') === 0) {
    next();
  } else {
    next({ name: 'configuration' });
  }
});

new Vue({
  router,
  store
}).$start();
