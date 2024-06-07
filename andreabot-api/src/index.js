const express = require('express');
require('dotenv').config();

const v1UsersRouter = require('./v1/routes/usersRoutes');
const v1AdminRouter = require('./v1/routes/adminRoutes');
const v1SupervisorRouter = require('./v1/routes/supervisorRoutes');
const v1EncuestadorRouter = require('./v1/routes/encuestadorRutes'); //TODO: Quitar lo de la imagen

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/api/v1/users', v1UsersRouter);
app.use('/api/v1/admin', v1AdminRouter);
app.use('/api/v1/supervisor', v1SupervisorRouter);
app.use('/api/v1/encuestador', v1EncuestadorRouter);


app.listen(PORT, () => {
    console.log(`📡 Servidor en ejecución en el puerto ${PORT} rey 🤙 `);
})

/*
const express = require('express');
const mysql = require('mysql2/promise');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});


console.log(process.env.DB_HOST);
console.log(process.env.DB_USER);  
console.log(process.env.DB_PASSWORD);
console.log(process.env.DB_DATABASE);*/

// Define a route to get all users
app.get('/prueba', (req, res) => {
    pool.query('SELECT * FROM usuario')
        .then(result => {
            res.status(200).send({ status: "OK", message: "Todos los usuarios obtenidos", data: result[0] });
        })
        .catch(error => {
            console.error(error);
            res.status(500).send({ status: "ERROR", message: "Error al obtener los usuarios", data: error });
        });
});

/*
app.listen(PORT, () => {
    console.log(`📡 Servidor en ejecución en el puerto ${PORT} rey 🤙 `);
})*/