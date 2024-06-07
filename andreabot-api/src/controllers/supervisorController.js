const supervisorServices = require('../services/supervisorServices')

const getLastCapDis = (req, res) => {
    supervisorServices.getLastCapDis().then(result => {

        res.status(200).send({ status: "200", message: "Distritos obtenidos", data: result });
    });
};

const getLastCapDisUsr = (req, res) => {
    supervisorServices.getLastCapDisUsr(req.query.distrito).then(result => {

        res.status(200).send({ status: "200", message: "Encuestas obtenidas", data: result });
    });
};

module.exports = {
    getLastCapDis,
    getLastCapDisUsr
};