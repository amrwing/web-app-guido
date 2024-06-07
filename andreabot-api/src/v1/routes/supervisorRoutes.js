const express = require('express');
const router = express.Router();
const supervisorController = require('../../controllers/supervisorController');
const authUsers= require('../../middlewares/authUsers');

router
.get('/all-distritos-encuestas', authUsers( ['admin', 'supervisor'] ), supervisorController.getLastCapDis)
.get('/all-distritos-encuestas-usuario', authUsers( ['admin', 'supervisor'] ), supervisorController.getLastCapDisUsr)


module.exports = router;