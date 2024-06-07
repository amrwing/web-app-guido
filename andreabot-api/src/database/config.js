const mysql = require('mysql2/promise');
//require('dotenv').config();

const pool = mysql.createPool({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    socketPath: `/cloudsql/${process.env.INSTANCE_CONNECTION_NAME}`,
});

/*const pool = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    waitForConnections: true,
    connectionLimit: 10, //TODO: Cambiar a lo requerido por el proyecto
    queueLimit: 0
});*/

module.exports = pool;