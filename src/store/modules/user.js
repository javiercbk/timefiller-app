/* eslint-disable no-shadow */
import * as fs from 'tns-core-modules/file-system';

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

const storeDataBeforeCommit = (options) => {
  const newData = {};
  newData[options.prop] = options.payload;
  const newUserState = Object.assign({}, options.state, newData);
  const dataToWrite = JSON.stringify(newUserState);
  return configFile
    .writeText(dataToWrite)
    .then(() => {
      options.commit(options.action, options.payload);
    })
    .catch((err) => {
      console.error(`Error writing config file: ${err.message || err} => ${err.stack}`);
    });
};

const hasFalsyProperty = (obj) => {
  const keys = Object.keys(obj);
  const len = keys.length;
  const nonFalsyLen = Object.keys(obj).filter(k => obj[k]).length;
  return len > nonFalsyLen;
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
  })
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
  setJira: ({ commit, state }, payload) => {
    storeDataBeforeCommit({
      commit,
      state,
      payload,
      prop: 'jira',
      action: 'setJira'
    });
  },
  setHarvest: ({ commit }, payload) => {
    storeDataBeforeCommit({
      commit,
      state,
      payload,
      prop: 'harvest',
      action: 'setHarvest'
    });
  },
  setWaka: ({ commit }, payload) => {
    storeDataBeforeCommit({
      commit,
      state,
      payload,
      prop: 'waka',
      action: 'setWaka'
    });
  },
  setReminder: ({ commit }, payload) => {
    storeDataBeforeCommit({
      commit,
      state,
      payload,
      prop: 'reminder',
      action: 'setReminder'
    });
  },
  load: ({ commit, state }) => {
    if (!state.initialized) {
      return configFile
        .readText()
        .then((storedConfig) => {
          if (storedConfig === '') {
            return state;
          }
          const conf = JSON.parse(storedConfig);
          conf.initialized = true;
          commit('setUser', conf);
          return conf;
        })
        .catch((err) => {
          console.error(`Error reading config file: ${err.message || err} JSON: ${JSON.stringify(err)}`);
        });
    }
    return Promise.resolve(state);
  }
};

module.exports = {
  state,
  getters,
  mutations,
  actions,
  namespaced: true
};
