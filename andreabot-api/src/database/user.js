const pool = require('./config');

//TODO: Implementar el manejo de errores, crashea cuando da error
const getUserById = async (id) => {
    try {
        const [rows] = await pool.query('SELECT * FROM usuario WHERE idusuario = ?', [id]);

        if (rows.length === 0) return { status: 404, output: "Usuario no encontrado" };

        return rows[0];
    }
    catch (error) {
        console.error('Error al buscar usuario por ID:', error);
        return { status: 500, output: error };
    }
};

module.exports = {
    getUserById
}