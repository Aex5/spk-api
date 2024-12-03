const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: '',
    database: 'spk'
  });

  connection.connect((err) => {
    if (err) {
      console.error('Error connecting SQL:', err);
      return;
    }
    console.log('Connected to SQL');
  });

  module.exports = connection;