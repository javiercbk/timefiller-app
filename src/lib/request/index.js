// eslint-disable-next-line import/no-unresolved,import/extensions
import * as https from 'nativescript-https';
import * as fs from 'tns-core-modules/file-system';

const http = require('http');

const dir = fs.knownFolders.currentApp().getFolder('certs');
const certificate = dir.getFile('*.atlassian.net').path;
https.enableSSLPinning({ host: 'atlassian.net', certificate });

export const request = (options) => {
  console.log(`options => ${JSON.stringify(options)}`);
  const fixedOptions = Object.assign({}, options);
  if (fixedOptions.uri) {
    fixedOptions.url = fixedOptions.uri;
    delete fixedOptions.uri;
  }
  if (fixedOptions.auth) {
    const encodedAuth = Buffer.from(`${fixedOptions.auth.user}:${fixedOptions.auth.pass}`).toString('base64');
    fixedOptions.headers = Object.assign({}, fixedOptions.headers, {
      Authorization: `Basic ${encodedAuth}`
    });
    delete fixedOptions.auth;
  }
  if (fixedOptions.body) {
    fixedOptions.content = fixedOptions.body;
    if (fixedOptions.json) {
      fixedOptions.content = JSON.stringify(fixedOptions.body);
      fixedOptions.headers = Object.assign({}, fixedOptions.headers, {
        'Content-Type': 'application/json'
      });
      delete fixedOptions.json;
    }
    delete fixedOptions.body;
  }
  console.log(`fixedOptions => ${JSON.stringify(fixedOptions)}`);
  if (fixedOptions.url.indexOf('https') === 0) {
    return https.request(fixedOptions);
  }
  return http.request(fixedOptions);
};
