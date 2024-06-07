const { text } = require('express');
const pool = require('./config');

//TODO: Bucar posibles crashes en las consultas
const getAllUsersEncuestas = async () => {
    try {
        const result = await pool.query(`
        SELECT 
            	usr.idusuario AS id_usuario,
            	rr.apellido_paterno, 
            	rr.apellido_materno, 
            	rr.nombre, 
            	COUNT(r.responsable_red_usuario_idusuario) AS total_capturas,
            	usr.activo,
                MAX(r.fecha_captura) AS ultima_captura
        FROM \`andreabot-db\`.usuario usr
        LEFT JOIN \`andreabot-db\`.responsable_red rr ON rr.usuario_idusuario = usr.idusuario
        LEFT JOIN \`andreabot-db\`.red r ON r.responsable_red_usuario_idusuario = usr.idusuario
        GROUP BY id_usuario
        ORDER BY total_capturas DESC;
        `);
        return result[0];
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }

}

const getAllEncuestas = async (filtro) => {
    try {
        if (filtro.origen && filtro.lider) {
            const result = await pool.query(`
            SELECT 
            	r.*,
                l.*
            FROM \`andreabot-db\`.lider l
            JOIN \`andreabot-db\`.responsable_red rr ON l.idlider = rr.lider_idlider
            JOIN \`andreabot-db\`.red r ON rr.usuario_idusuario = r.responsable_red_usuario_idusuario
            WHERE l.origen_idorigen = ? AND l.idlider = ?;
            `, [filtro.origen, filtro.lider]);
            return result[0];
        }
        
        if (filtro.origen) {
            const result = await pool.query(`
            SELECT 
            	r.*,
                l.*
            FROM \`andreabot-db\`.lider l
            JOIN \`andreabot-db\`.responsable_red rr ON l.idlider = rr.lider_idlider
            JOIN \`andreabot-db\`.red r ON rr.usuario_idusuario = r.responsable_red_usuario_idusuario
            WHERE l.origen_idorigen = ?;
            `, [filtro.origen]);
            return result[0];
        }
        const result = await pool.query(`
        SELECT 
        	r.*,
            l.*
        FROM \`andreabot-db\`.lider l
        JOIN \`andreabot-db\`.responsable_red rr ON l.idlider = rr.lider_idlider
        JOIN \`andreabot-db\`.red r ON rr.usuario_idusuario = r.responsable_red_usuario_idusuario;
        `);
        return result[0];
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};

const getAllSupervisores = async () => {
    try {
        const result = await pool.query(`
        SELECT
        	idusuario,
            activo
        FROM \`andreabot-db\`.usuario
        WHERE rol_idrol = "supervisor";
        `);
        return result[0];
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};

const getAllUsers = async () => {
    try {
        const result = await pool.query('SELECT * FROM usuario')
        return result[0];
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};

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

const addUser = async (user) => {
    try {
        const result = await pool.query('INSERT INTO usuario (idusuario, pass, activo, rol_idrol) VALUES (?, ?, ?, ?)', [user.id, user.pass, user.activo, user.rol]);
        return result[0];
    }
    catch (error) {
        console.error('Error al insertar usuario:', error);
        if (error.code === 'ER_NO_REFERENCED_ROW_2' || error.code === 'ER_TRUNCATED_WRONG_VALUE') {
            return { status: 400, output: error };
        }
        if (error.code === 'ER_DUP_ENTRY') {
            return { status: 409, output: { message: error.message, code: error.code } };
        }
        return { status: 500, output: error };
    }
};

const addOrigin = async (origin) => {
    try {
        const result = await pool.query('INSERT INTO origen (idorigen) VALUES (?)', [origin]);
        return result[0];
    }
    catch (error) {
        console.error('Error al insertar origen:', error);
        if (error.code === 'ER_NO_REFERENCED_ROW_2' || error.code === 'ER_TRUNCATED_WRONG_VALUE') {
            return { status: 400, output: error };
        }
        if (error.code === 'ER_DUP_ENTRY') {
            return { status: 409, output: { message: error.message, code: error.code } };
        }
        return { status: 500, output: error };
    }
}

const addLider = async (nuevoLider) => {
    try {
        const result = await pool.query('INSERT INTO lider (idlider, telefono, origen_idorigen) VALUES (?, ?, ?)', [nuevoLider.lider, nuevoLider.telefono, nuevoLider.origen]);
        return result[0];
    }
    catch (error) {
        console.error('Error al insertar lider:', error);
        if (error.code === 'ER_NO_REFERENCED_ROW_2' || error.code === 'ER_TRUNCATED_WRONG_VALUE') {
            return { status: 400, output: error };
        }
        if (error.code === 'ER_DUP_ENTRY') {
            return { status: 409, output: { message: error.message, code: error.code } };
        }
        return { status: 500, output: error };
    }
};

const deactivateUser = async (id) => {
    try {
        const [result] = await pool.query('UPDATE usuario SET activo = 0 WHERE idusuario = ?', [id]);
        if (result.affectedRows === 0) { return { status: 404, output: "Usuario no encontrado" }; }
        return { "affectedRows": result.affectedRows };
    } catch (error) {
        console.error('Error al desactivar usuario por ID:', error);
        if (error.code === 'ER_NO_REFERENCED_ROW_2' || error.code === 'ER_TRUNCATED_WRONG_VALUE') {
            return { status: 400, output: error.code };
        }
        return { status: 500, output: error };
    }
};

const updateUser = async (updateUser) => {
    try {
        const [result] = await pool.query('UPDATE usuario SET pass = ? WHERE idusuario = ?', [updateUser.pass, updateUser.id]);
        if (result.affectedRows === 0) { return { status: 404, output: "Usuario no encontrado" }; }
        return { "info": result.info };
    }
    catch {
        console.error('Error al actualizar usuario por ID:', error);
        if (error.code === 'ER_NO_REFERENCED_ROW_2' || error.code === 'ER_TRUNCATED_WRONG_VALUE') {
            return { status: 400, output: error.code };
        }
        return { status: 500, output: error };
    
    }
};

module.exports = {
    getAllUsersEncuestas,
    getAllEncuestas,
    getAllUsers,
    getAllSupervisores,
    getUserById,
    addUser,
    addLider,
    addOrigin,
    deactivateUser,
    updateUser
}