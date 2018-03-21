/* eslint-disable import/first */
import Vue from 'nativescript-vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import Configuration from '../components/configuration/configuration.vue';
import ConfigJira from '../components/configuration/jira-config.vue';
import ConfigHarvest from '../components/configuration/harvest-config.vue';
import ConfigWaka from '../components/configuration/waka-config.vue';
import ConfigReminder from '../components/configuration/reminder-config.vue';
import Home from '../components/home/home.vue';

const router = new VueRouter({
  pageRouting: true,
  routes: [
    {
      path: '/home',
      name: 'home',
      component: Home
    },
    {
      path: '/configuration',
      name: 'configuration',
      component: Configuration
    },
    {
      path: '/jira',
      name: 'config-jira',
      component: ConfigJira
    },
    {
      path: '/harvest',
      name: 'config-harvest',
      component: ConfigHarvest
    },
    {
      path: '/waka',
      name: 'config-waka',
      component: ConfigWaka
    },
    {
      path: 'reminder',
      name: 'config-reminder',
      component: ConfigReminder
    },
    { path: '*', redirect: '/home' }
  ]
});

router.replace('/home');

module.exports = router;
