const Supervisor = require('../database/supervisor');

const getLastCapDis = async () => {
    const distritos = await Supervisor.getLastCapDis();
    return distritos;
};

const getLastCapDisUsr = async (distrito) => {
    //TODO: Validar campos
    const encuestas = await Supervisor.getLastCapDisUsr(distrito);
    return encuestas;
}

module.exports = {
    getLastCapDis,
    getLastCapDisUsr
};