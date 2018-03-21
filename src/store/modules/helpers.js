export const readFileAndInitialize = ({
  commit, state, initProp, file, action
}) => {
  if (!state[initProp]) {
    return file
      .readText()
      .then((storedData) => {
        if (storedData === '') {
          return state;
        }
        const parsedData = JSON.parse(storedData);
        parsedData[initProp] = true;
        commit(action, parsedData);
        return parsedData;
      })
      .catch((err) => {
        console.error(`Error reading file: ${err.message || err} JSON: ${JSON.stringify(err)}`);
      });
  }
  return Promise.resolve(state);
};

export const storeDataBeforeCommit = (options) => {
  const newData = {};
  newData[options.prop] = options.payload;
  const newUserState = Object.assign({}, options.state, newData);
  const dataToWrite = JSON.stringify(newUserState);
  return options.file
    .writeText(dataToWrite)
    .then(() => {
      options.commit(options.action, options.payload);
    })
    .catch((err) => {
      console.error(`Error writing config file: ${err.message || err} => ${err.stack}`);
    });
};

export const hasFalsyProperty = (obj) => {
  const keys = Object.keys(obj);
  const len = keys.length;
  const nonFalsyLen = Object.keys(obj).filter(k => obj[k]).length;
  return len > nonFalsyLen;
};
