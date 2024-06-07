const jwt = require('jsonwebtoken');


const authMiddleware = (allowedRoles) => {
    return (req, res, next) => {
        // Verificar si existe el token
        const token = req.headers.authorization;
        if (!token) {
            return res.status(401).json({ message: 'Token de autorización no proporcionado' });
        }

        // Verificar el token
        jwt.verify(token, 'mysecretkey', (err, decodedToken) => {
            if (err) {
                return res.status(401).json({ message: 'Token de autorización inválido' });
            }

            // Verificar el rol
            if (!allowedRoles.includes(decodedToken.user.rol)) {
                return res.status(403).json({ message: 'No tienes permiso para acceder a este recurso' });
            }

            req.user = decodedToken; // Agregar el usuario decodificado al objeto req
            next();
        });
    };
};

module.exports = authMiddleware;
