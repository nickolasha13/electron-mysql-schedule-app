const mysql = require('mysql2');
const { contextBridge } = require('electron');

let connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'pziyjmea',
  database: 'nure_timetable',
  port: '3306'
});

connection.connect();

contextBridge.exposeInMainWorld('database', {
  getTables: () => {
    return new Promise((resolve, reject) => {
      connection.query('SHOW TABLES', (error, results, fields) => {
        if (error) reject(error);
        resolve(results);
      });
    });
  },
});
