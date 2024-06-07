const { v4: uuidv4 } = require('uuid');
const moment = require('moment-timezone');
const Encustador = require('../database/encuestador');
//const { Storage } = require('@google-cloud/storage');


/* Ya no se necesita subir imagenes
const proyecto = process.env.GOOGLE_PROYECT_ID;
const keyFilename = process.env.GOOGLE_KEY_FILE_NAME;
const storage = new Storage({ projectId: proyecto, keyFilename: keyFilename });

const uploadImageToCloudStorage = async (file, name) => {
    const bucket = storage.bucket(process.env.GOOGLE_BUCKET_NAME);
    const uniqueFilename = name;
    const blob = bucket.file(uniqueFilename);
    const blobStream = blob.createWriteStream({
        resumable: false
    });

    return new Promise((resolve, reject) => {
        blobStream.on('error', (err) => {
            reject(err);
        });

        blobStream.on('finish', async () => {
            const publicUrl = ``;
            resolve(publicUrl);
        });

        blobStream.end(file.buffer);
    });
};
*/


const uploadEncuesta = async (req, res) => {
    //TODO: Validar campos

    const id = uuidv4();
    const actualTime = moment.tz(process.env.TIME_ZONE).format('YYYY-MM-DD HH:mm:ss');

    const encuesta = {
        id: id,
        fecha_captura: actualTime,
        apellido_paterno: req.body.apellido_paterno,
        apellido_materno: req.body.apellido_materno,
        nombre: req.body.nombre,
        domicilio: req.body.domicilio,
        no_ext: req.body.no_ext,
        no_int: req.body.no_int || "",
        fraccionamiento: req.body.fraccionamiento,
        distrito: req.body.distrito,
        seccion: req.body.seccion,
        fecha_nacimiento: req.body.fecha_nacimiento,
        telefono: req.body.telefono,
        celular: req.body.celular || "",
        perfil_facebook: req.body.perfil_facebook || "",
        clave_elector: req.body.clave_elector,
        id_responsable: req.body.id_responsable
    }
    const uploadedEncuesta = await Encustador.uploadEncuesta(encuesta);
    return uploadedEncuesta;
};

const uploadDataResponsable = async (req, res) => {
    //TODO: Validar campos
    const datos = {
        id: req.body.id,
        apellido_paterno: req.body.apellido_paterno,
        apellido_materno: req.body.apellido_materno,
        nombre: req.body.nombre,
        domicilio: req.body.domicilio,
        no_ext: req.body.no_ext,
        no_int: req.body.no_int || "",
        fraccionamiento: req.body.fraccionamiento,
        distrito: req.body.distrito,
        seccion: req.body.seccion,
        fecha_nacimiento: req.body.fecha_nacimiento,
        telefono: req.body.telefono,
        celular: req.body.celular || "",
        perfil_facebook: req.body.perfil_facebook || "",
        clave_elector: req.body.clave_elector,
        lider: req.body.lider,   
    }
    const uploadedData = await Encustador.uploadDataResponsable(datos);
    return uploadedData;
};

const getResponsableById = async (req, res) => {
    //TODO: Validar campos
    const id = req.query.id;
    const responsable = await Encustador.getResponsableById(id);
    return responsable;
};

const getAllOrigenes = async (req, res) => {
    const origenes = await Encustador.getAllOrigenes();
    return origenes;
}

const getLideresByOrigen = async (req, res) => {
    const origen = req.query.origen;
    const lideres = await Encustador.getLiderByOrigen(origen);
    return lideres;
}

const updateResponsableById = async (req, res) => {
    //TODO: Validar campos
    const id = req.body.id;
    const datos = {
        apellido_paterno: req.body.apellido_paterno,
        apellido_materno: req.body.apellido_materno,
        nombre: req.body.nombre,
        domicilio: req.body.domicilio,
        no_ext: req.body.no_ext,
        no_int: req.body.no_int || "",
        fraccionamiento: req.body.fraccionamiento,
        distrito: req.body.distrito,
        seccion: req.body.seccion,
        fecha_nacimiento: req.body.fecha_nacimiento,
        telefono: req.body.telefono,
        celular: req.body.celular || "",
        perfil_facebook: req.body.perfil_facebook || "",
        clave_elector: req.body.clave_elector,
        lider: req.body.lider,
    }

    const updatedData = await Encustador.updateResponsableById(id, datos);
    return updatedData;
};

module.exports = {
    uploadDataResponsable,
    uploadEncuesta,
    getResponsableById,
    getAllOrigenes,
    getLideresByOrigen,
    updateResponsableById
}