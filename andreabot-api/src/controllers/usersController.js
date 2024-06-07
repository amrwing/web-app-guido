const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const userServices = require('../services/usersService');

const login = (req, res) => {
    const { id, pass } = req.body;
    userServices.login(id).then(result => {
        if (result.status === 404) {
            res.status(404).send({ status: "404", message: "Usuario no encontrado", data: result });
            return;
        }
        if (result.status === 500) {
            res.status(500).send({ status: "500", message: "Error al buscar usuario", data: result });
            return;
        }

        if(result.activo === 0) {
            res.status(401).send({ status: "401", message: "Usuario restringido"});
            return;
        }

        bcrypt.compare(pass, result.pass)
            .then(validPassword => {
                if (!validPassword) {
                    return res.status(401).json({ message: 'Contraseña invalida' });
                }

                const tokenData = {
                    userId: id,
                    rol: result.rol_idrol
                }
                const token = jwt.sign({ user: tokenData }, 'mysecretkey', { expiresIn: '1h' });
                const rol =result.rol_idrol
                res.status(200).send({ status: "200", data: { token: token, rol: rol } });
            })
            .catch(error => {
                console.error('Error al comparar intentar iniciar seción:', error);
                res.status(500).send({ status: "500", message: "Error al comparar intentar iniciar seción", data: error });
            });
    });

}

module.exports = {
    login
}