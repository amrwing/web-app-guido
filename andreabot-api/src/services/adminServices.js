const bcrypt = require('bcrypt');
const Admin = require('../database/admin');

const getAllUsersEncuesta = async () => {
    const allUsers = await Admin.getAllUsersEncuestas();
    return allUsers;
};

const getAllEncuestas = async () => {
    const allEncuestas = await Admin.getAllEncuestas();
    return allEncuestas;
};

const getAllSupervisores = async () => {
    const allSupervisores = await Admin.getAllSupervisores();
    return allSupervisores;
};

const createUser = async (req, res) => {
    //TODO: Validar campos y quitar espacios al inicio y final
    
    const salt = await bcrypt.genSalt(10);
    const hashedPass = await bcrypt.hash(req.body.pass, salt);

    const user = {
        id: req.body.id,
        pass: hashedPass,
        rol: req.body.rol,
        activo: 1
    }
    const createdUser = await Admin.addUser(user);
    return createdUser;
};

const createOrigin = async (req, res) => {
    //TODO: Validar campos y quitar espacios al inicio y final
    const origin = req.body.origen;
    const createdOrigin = await Admin.addOrigin(origin);
    return createdOrigin;
};

const createLider = async (req, res) => {
    //TODO: Validar campos y quitar espacios al inicio y final
    const nuevoLider = {
        lider: req.body.lider,
        telefono: req.body.telefono,
        origen: req.body.origen
    };
    const createdLider = await Admin.addLider(nuevoLider);
    return createdLider;
};

const deactivateUser = async (id) => {
    const deletedUser = await Admin.deactivateUser(id);
    return deletedUser;
};

module.exports = {
    getAllUsersEncuesta,
    getAllEncuestas,
    getAllSupervisores,
    createUser,
    createLider,
    createOrigin,
    deactivateUser
};
