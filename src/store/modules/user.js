/* eslint-disable no-shadow */
import * as fs from 'tns-core-modules/file-system';
import { readFileAndInitialize, storeDataBeforeCommit, hasFalsyProperty } from './helpers';

const documents = fs.knownFolders.documents();
const configFile = documents.getFile('config.json');

const state = {
  initialized: false,
  jira: {
    host: '',
    username: '',
    password: ''
  },
  harvest: {
    subdomain: '',
    email: '',
    password: ''
  },
  waka: {
    apiKey: ''
  },
  reminder: {
    hour: 10,
    minute: 0
  }
};

const getters = {
  isConfigured: storeState =>
    !hasFalsyProperty(storeState.jira) &&
    !hasFalsyProperty(storeState.harvest) &&
    !hasFalsyProperty(storeState.waka),
  jira: storeState => storeState.jira,
  harvest: storeState => storeState.harvest,
  waka: storeState => storeState.waka,
  reminder: storeState => storeState.reminder,
  credentials: storeState => ({
    jira: storeState.jira,
    harvest: storeState.harvest,
    waka: storeState.waka
  }),
  workLogs: storeState => storeState.workLogs
};

const mutations = {
  setJira: (storeState, payload) => {
    storeState.jira = payload;
  },
  setHarvest: (storeState, payload) => {
    storeState.harvest = payload;
  },
  setWaka: (storeState, payload) => {
    storeState.waka = payload;
  },
  setReminder: (storeState, payload) => {
    storeState.reminder = payload;
  },
  setUser: (storeState, payload) => {
    Object.assign(storeState, payload);
  }
};

const actions = {
  setJira: ({ commit, state }, payload) =>
    storeDataBeforeCommit({
      commit,
      state,
      payload,
      file: configFile,
      prop: 'jira',
      action: 'setJira'
    }),
  setHarvest: ({ commit }, payload) =>
    storeDataBeforeCommit({
      commit,
      state,
      payload,
      file: configFile,
      prop: 'harvest',
      action: 'setHarvest'
    }),
  setWaka: ({ commit }, payload) =>
    storeDataBeforeCommit({
      commit,
      state,
      payload,
      file: configFile,
      prop: 'waka',
      action: 'setWaka'
    }),
  setReminder: ({ commit }, payload) =>
    storeDataBeforeCommit({
      commit,
      state,
      payload,
      file: configFile,
      prop: 'reminder',
      action: 'setReminder'
    }),
  load: ({ commit, state }) =>
    readFileAndInitialize({
      commit,
      state,
      initProp: 'initialized',
      file: configFile,
      action: 'setUser'
    })
};

module.exports = {
  state,
  getters,
  mutations,
  actions,
  namespaced: true
};
