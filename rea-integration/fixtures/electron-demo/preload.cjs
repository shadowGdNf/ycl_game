const { contextBridge, ipcRenderer } = require('electron');
contextBridge.exposeInMainWorld('levelApi', {
  search: (query) => ipcRenderer.invoke('levels:search', query)
});
