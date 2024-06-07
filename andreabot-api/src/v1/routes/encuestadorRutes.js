const express = require('express');
const router = express.Router();
const encuestadorController = require('../../controllers/encuestadorController');
const authUsers = require('../../middlewares/authUsers');
const file = require('../../middlewares/fileStorage');

router
    .post('/upload-data-responsable', authUsers(['admin', 'encuestador']), encuestadorController.uploadDataResponsable)
    .post('/upload-encuesta', authUsers(['admin', 'encuestador']), encuestadorController.uploadEncuesta)
    //.post('/upload-encuesta', authUsers(['admin', 'encuestador']), file.upload.single('file'), encuestadorController.uploadEncuesta)
    .get('/get-responsable', authUsers(['admin', 'encuestador']), encuestadorController.getResponsableById) //TODO: Mencionar en la documentacion que se utilice %20 en caso de tener espacios en el id
    .get('/get-all-origenes', authUsers(['admin', 'encuestador']), encuestadorController.getAllOrigenes)
    .get('/get-lideres-origen', authUsers(['admin', 'encuestador']), encuestadorController.getLideresByOrigen)
    .put('/update-data-responsable', authUsers(['admin', 'encuestador']), encuestadorController.updateResponsableById);
module.exports = router;