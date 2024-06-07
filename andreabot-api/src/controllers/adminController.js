const adminServices = require('../services/adminServices');

const getAllUsersEncuesta = (req, res) => {
    adminServices.getAllUsersEncuesta().then(result => {
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al obtener los usuarios", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Todos los usuarios obtenidos", data: result });
    });
};

const getAllEncuestas = (req, res) => {
    adminServices.getAllEncuestas(req).then(result => {
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al obtener las encuestas", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Todas las encuestas obtenidas", data: result });
    });
}

const getAllSupervisores = (req, res) => {
    adminServices.getAllSupervisores().then(result => {
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al obtener los supervisores", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Todos los supervisores obtenidos", data: result });
    });
};

const createUser = (req, res) => {
    adminServices.createUser(req, res).then(result => {
        if (result.status === 400) {
            res.status(400).send({ status: "400", message: "Datos enviados incorrectos", data: result });
            return;
        }
        if (result.status === 409) {
            res.status(409).send({ status: "409", message: "Usuario ya existe", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al crear usuario", data: result });
            return;
        }
        res.status(201).send({ status: "201", message: "Usuario creado", data: result });
    });
};

const createOrigin = (req, res) => {
    adminServices.createOrigin(req, res).then(result => {
        if (result.status === 400) {
            res.status(400).send({ status: "400", message: "Datos enviados incorrectos", data: result });
            return;
        }
        if (result.status === 409) {
            res.status(409).send({ status: "409", message: "Origen ya existe", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al crear origen", data: result });
            return;
        }
        res.status(201).send({ status: "201", message: "Origen creado", data: result });
    });
};

const createLider = (req, res) => {
    adminServices.createLider(req, res).then(result => {
        if (result.status === 400) {
            res.status(400).send({ status: "400", message: "Datos enviados incorrectos", data: result });
            return;
        }
        if (result.status === 409) {
            res.status(409).send({ status: "409", message: "Lider ya existe", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al crear lider", data: result });
            return;
        }
        res.status(201).send({ status: "201", message: "Lider creado", data: result });
    });
}

const deactivateUser = (req, res) => {
    adminServices.deactivateUser(req.body.id).then(result => {
        if (result.status === 400) {
            res.status(400).send({ status: "400", message: "Datos enviados incorrectos", data: result });
            return;
        }
        if (result.status === 404) {
            res.status(404).send({ status: "404", message: "Usuario no encontrado", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al buscar usuario", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Usuario eliminado", data: result });
    });
};

const updateUser = (req, res) => {
    adminServices.updateUser(req, res).then(result => {
        if (result.status === 400) {
            res.status(400).send({ status: "400", message: "Datos enviados incorrectos", data: result });
            return;
        }
        if (result.status === 404) {
            res.status(404).send({ status: "404", message: "Usuario no encontrado", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al buscar usuario", data: result });
            return;
        }
        res.status(200).send({ status: "200", message: "Usuario actualizado", data: result });
    });

};

module.exports = {
    getAllUsersEncuesta,
    getAllEncuestas,
    getAllSupervisores,
    createUser,
    createOrigin,
    createLider,
    deactivateUser,
    updateUser
}