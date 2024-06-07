const encuestadorService = require('../services/encuestadorServices');

const uploadDataResponsable = (req, res) => {
    encuestadorService.uploadDataResponsable(req, res)
    .then(result => {
        if (result.status === 400) {
            res.status(400).send({ status: "400", message: "Datos enviados no validos", data: result });
            return;
        }
        if (result.status === 409) {
            res.status(409).send({ status: "409", message: "Datos duplicados", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Datos cargador", data: result });
            return;
        }
        res.status(201).send({ status: "201", message: "Datos cargados", data: result });
    })

}

const uploadEncuesta = (req, res) => {
    encuestadorService.uploadEncuesta(req, res)
    .then(result => {
        if (result.status === 400) {
            res.status(400).send({ status: "400", message: "Datos enviados no validos", data: result });
            return;
        }
        if (result.status === 409) {
            res.status(409).send({ status: "409", message: "Datos duplicados", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al intentar cargar la respuesta", data: result });
            return;
        }
        res.status(201).send({ status: "201", message: "Respuesta cargada", data: result });
    })
};

const getResponsableById = (req, res) => {
    encuestadorService.getResponsableById(req, res)
    .then(result => {
        if (result.status === 404) {
            res.status(404).send({ status: "404", message: "No se encontro el responsable de red", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al intentar obtener el responsable de red", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Responsable de red encontrado", data: result });
    })
};

const getAllOrigenes = (req, res) => {
    encuestadorService.getAllOrigenes(req, res)
    .then(result => {
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al intentar obtener los origenes", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Origenes obtenidos", data: result });
    })

}

const getLideresByOrigen = (req, res) => {
    encuestadorService.getLideresByOrigen(req, res)
    .then(result => {
        if (result.status === 404) {
            res.status(404).send({ status: "404", message: "No se encontraron lideres", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al intentar obtener el lider", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Lider encontrado", data: result });
    })

}

const updateResponsableById = (req, res) => {
    encuestadorService.updateResponsableById(req, res)
    .then(result => {
        if (result.status === 400) {
            res.status(400).send({ status: "400", message: "Datos enviados no validos", data: result });
            return;
        }
        if (result.status === 404) {
            res.status(404).send({ status: "404", message: "No se encontro el responsable de red", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al intentar actualizar el responsable de red", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Responsable de red actualizado", data: result });
    })
};

module.exports = {
    uploadDataResponsable,
    uploadEncuesta,
    getResponsableById,
    getAllOrigenes,
    getLideresByOrigen,
    updateResponsableById
};