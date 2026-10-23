throw new Error('REA_STATIC_FIXTURE_MUST_NOT_EXECUTE');
const { app, BrowserWindow, ipcMain } = require('electron');
const { searchLevels } = require('./search.cjs');
ipcMain.handle('levels:search', (_event, query) => searchLevels(query));
app.whenReady().then(() => {
  const window = new BrowserWindow({
    webPreferences: { preload: require('node:path').join(__dirname, 'preload.cjs') }
  });
  window.loadFile('index.html');
});
