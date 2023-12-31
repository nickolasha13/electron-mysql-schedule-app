const { app, BrowserWindow } = require('electron')
const path = require('path')

const createWindow = () => {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
        preload: path.join(__dirname, 'preload.js'),
        contextIsolation: false,
        nodeIntegration: true,
    }
  })

  win.loadFile('index.html')
}


app.whenReady().then(() => {
createWindow()
})

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
    app.quit()
    }
})

app.whenReady().then(() => {
    createWindow()
  
    app.on('activate', () => {
      if (BrowserWindow.getAllWindows().length === 0) createWindow()
    })
  })