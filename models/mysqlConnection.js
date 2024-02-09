const mysql = require('mysql');
const dbConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'payroll'
});

module.exports = dbConnection;