const pool = require('./config');

//TODO: Bucar posibles crashes en las consultas

const getLastCapDis = async () => {
    try {
        const result = await pool.query(`
            SELECT 
            	distrito,
                COUNT(*) AS total_capturas,
                MAX(fecha_captura) AS ultima_captura
            FROM \`andreabot-db\`.red
            GROUP BY distrito;
        `);
        return result[0];
    }
    catch (error) {
        console.error("Error en la consulta:", error);
        return { status: 500, output: error };
    }
};


const getLastCapDisUsr = async (distrito) => {
    try {
        const result = await pool.query(`
            SELECT
            	rr.usuario_idusuario AS id_usuario,
            	rr.nombre,
                rr.apellido_paterno,
                rr.apellido_materno,
                COUNT(re.responsable_red_usuario_idusuario) AS total_capturas,
                MAX(re.fecha_captura) AS ultima_captura
            FROM \`andreabot-db\`.responsable_red rr
            LEFT JOIN \`andreabot-db\`.red re ON rr.usuario_idusuario = re.responsable_red_usuario_idusuario
            WHERE re.distrito = ?
            GROUP BY id_usuario
            ORDER BY ultima_captura DESC;
        `, [distrito]);

        return result[0];
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
    getLastCapDis,
    getLastCapDisUsr
}