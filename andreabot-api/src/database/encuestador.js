const pool = require('./config');


const uploadEncuesta = async (datos) => {
    try {
        const result = await pool.query(`
        INSERT INTO red 
        (idred, fecha_captura, apellido_paterno, apellido_materno, nombre, domicilio, no_ext, no_int, fraccionamiento, distrito, seccion, fecha_nacimiento, telefono, celular, perfil_facebook, clave_elector, responsable_red_usuario_idusuario) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `, [
            datos.id,
            datos.fecha_captura,
            datos.apellido_paterno,
            datos.apellido_materno,
            datos.nombre,
            datos.domicilio,
            datos.no_ext,
            datos.no_int,
            datos.fraccionamiento,
            datos.distrito,
            datos.seccion,
            datos.fecha_nacimiento,
            datos.telefono,
            datos.celular,
            datos.perfil_facebook,
            datos.clave_elector,
            datos.id_responsable
        ]);

        return { status: 200, output: result[0] };
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        if (error.code === 'ER_NO_REFERENCED_ROW_2' || error.code === 'ER_TRUNCATED_WRONG_VALUE') {
            return { status: 400, output: error };
        }
        if (error.code === 'ER_DUP_ENTRY') {
            return { status: 409, output: { message: error.message, code: error.code } };
        }
        return { status: 500, output: error };
    }
};

const uploadDataResponsable = async (datos) => {
    try {//16
        const result = await pool.query(`
        INSERT INTO responsable_red 
        (usuario_idusuario, apellido_paterno, apellido_materno, nombre, domicilio, no_ext, no_int, fraccionamiento, distrito, seccion, fecha_nacimiento, telefono, celular, perfil_facebook, clave_elector, lider_idlider) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `, [
            datos.id,
            datos.apellido_paterno,
            datos.apellido_materno,
            datos.nombre,
            datos.domicilio,
            datos.no_ext,
            datos.no_int,
            datos.fraccionamiento,
            datos.distrito,
            datos.seccion,
            datos.fecha_nacimiento,
            datos.telefono,
            datos.celular,
            datos.perfil_facebook,
            datos.clave_elector,
            datos.lider
        ]);

        return { status: 200, output: result[0] };
    }
    catch (error) {
        if (error.code === 'ER_NO_REFERENCED_ROW_2' || error.code === 'ER_TRUNCATED_WRONG_VALUE') {
            return { status: 400, output: error };
        }
        if (error.code === 'ER_DUP_ENTRY') {
            return { status: 409, output: { message: error.message, code: error.code } };
        }
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};

const getResponsableById = async (id) => {
    try {
        const result = await pool.query(`
        SELECT 
        	rr.*,
            l.origen_idorigen
        FROM \`andreabot-db\`.responsable_red rr
        LEFT JOIN \`andreabot-db\`.lider l ON l.idlider = rr.lider_idlider
        WHERE rr.usuario_idusuario = ?;
    `, [id]);

        if (result[0].length === 0) {
            return { status: 404, output: { message: "No se encontro el responsable de red" } };
        }
        return { status: 200, output: result[0] };
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};

const getAllOrigenes = async () => {
    try {
        const result = await pool.query(`
        SELECT * FROM origen
    `);

        return { status: 200, output: result[0] };
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};

const getLiderByOrigen = async (origen) => {
    try {
        const result = await pool.query(`
        SELECT * FROM lider WHERE origen_idorigen = ?
    `, [origen]);

        if (result[0].length === 0) {
            return { status: 404, output: { message: "No se encontro el lider" } };
        }
        return { status: 200, output: result[0] };
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};

const updateResponsableById = async (id, datos) => {
    try {
        const result = await pool.query(`
        UPDATE responsable_red 
        SET apellido_paterno = ?, apellido_materno = ?, nombre = ?, domicilio = ?, no_ext = ?, no_int = ?, fraccionamiento = ?, distrito = ?, seccion = ?, fecha_nacimiento = ?, telefono = ?, celular = ?, perfil_facebook = ?, clave_elector = ?, lider_idlider = ?
        WHERE usuario_idusuario = ?
    `, [
            datos.apellido_paterno,
            datos.apellido_materno,
            datos.nombre,
            datos.domicilio,
            datos.no_ext,
            datos.no_int,
            datos.fraccionamiento,
            datos.distrito,
            datos.seccion,
            datos.fecha_nacimiento,
            datos.telefono,
            datos.celular,
            datos.perfil_facebook,
            datos.clave_elector,
            datos.lider,
            id
        ]);

        if (result[0].affectedRows === 0) {
            return { status: 404, output: { message: "No se encontro el responsable de red" } };
        }
        return { status: 200, output: result[0] };
    }
    catch (error) {
        if (error.code === 'ER_NO_REFERENCED_ROW_2' || error.code === 'ER_TRUNCATED_WRONG_VALUE') {
            return { status: 400, output: error };
        }
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};

module.exports = {
    uploadDataResponsable,
    uploadEncuesta,
    getResponsableById,
    getAllOrigenes,
    getLiderByOrigen,
    updateResponsableById
};