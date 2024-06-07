const express = require('express');
const router = express.Router();
const adminController = require('../../controllers/adminController');
const authUsers= require('../../middlewares/authUsers');

router
    .get('/get-all-responsables', authUsers( ['admin'] ),adminController.getAllUsersEncuesta)
    .get('/get-all-encuestas', authUsers( ['admin'] ),adminController.getAllEncuestas) //TODO: Nuevos parametros de seleccion y filtrado en obtener todas las encuestas
    .get('get-all-supervisores', authUsers( ['admin'] ),adminController.getAllSupervisores)
    .post('/create-user', authUsers( ['admin'] ), adminController.createUser)
    .post('/create-origin', authUsers( ['admin'] ), adminController.createOrigin)
    .post('/create-lider', authUsers( ['admin'] ), adminController.createLider)
    .delete('/del-user', authUsers( ['admin'] ), adminController.deactivateUser)

module.exports = router;