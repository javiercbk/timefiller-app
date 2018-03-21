/* eslint-disable no-shadow */
import * as fs from 'tns-core-modules/file-system';
import { readFileAndInitialize } from './helpers';

const documents = fs.knownFolders.documents();
const worklogsFile = documents.getFile('worklogs.json');

const MAX_WORK_LOGS = 100;

const _addWorklog = (worklogs, worklog) => {
  const len = worklogs.length;
  if (len > MAX_WORK_LOGS) {
    // remove the last worklog
    worklogs.splice(-1, 1);
  }
  worklogs.unshift(worklog);
};

const state = {
  initialized: false,
  worklogs: []
};

const getters = {
  worklogs: storeState => storeState.worklogs
};

const mutations = {
  setWorklogs: (storeState, payload) => {
    Object.assign(storeState, payload);
  },
  addWorklog: (storeState, payload) => {
    _addWorklog(storeState.worklogs, payload);
  }
};

const actions = {
  addWorklog: ({ commit, state }, payload) => {
    const clone = state.worklogs.slice(0);
    _addWorklog(clone, payload);
    const dataToWrite = JSON.stringify({ worklogs: clone });
    return worklogsFile
      .writeText(dataToWrite)
      .then(() => {
        commit('addWorklog', payload);
      })
      .catch((err) => {
        console.error(`Error writing config file: ${err.message || err} => ${err.stack}`);
      });
  },
  loadWorklogs: ({ commit, state }) =>
    readFileAndInitialize({
      commit,
      state,
      initProp: 'initialized',
      file: worklogsFile,
      action: 'setWorklogs'
    })
};

module.exports = {
  state,
  getters,
  mutations,
  actions,
  namespaced: true
};
