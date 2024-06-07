import 'dart:convert';
import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/models/usuario.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

abstract class ApiRequests {
  static Future<dynamic> logIn(String usuario, String password) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_LOGIN']!;
    final url = Uri.parse(urlApi);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'id': usuario, 'pass': password}),
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      jsonResponse['usuario'] = usuario;
      Fluttertoast.showToast(msg: "Bienvenido");
      return Usuario.fromJson(jsonResponse);
    } else if (jsonResponse['status'] == "404") {
      Fluttertoast.showToast(msg: "No existe este usuario");
      return null;
    } else if (jsonResponse['status'] == null) {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return null;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return null;
    }
  }

  static Future<bool> createUser(Usuario usuario) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_ADMIN_CREATE_USER']!;
    final url = Uri.parse(urlApi);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
      body: json.encode({
        'id': usuario.usuario,
        'pass': usuario.password,
        "rol": usuario.role
      }),
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "201") {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<bool> createOrigen(String nuevoOrigen) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_ADMIN_CREATE_ORIGIN']!;
    final url = Uri.parse(urlApi);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
      body: json.encode({
        'origen': nuevoOrigen,
      }),
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "201") {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<bool> createLider(
      String origenSeleccionado, String nombreLider, String telefono) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_ADMIN_CREATE_LIDER']!;
    final url = Uri.parse(urlApi);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
      body: json.encode({
        'lider': nombreLider,
        'origen': origenSeleccionado,
        'telefono': telefono,
      }),
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "201") {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<dynamic> getAllResponsablesDeRed() async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_ADMIN_ALL_USERS']!;
    final url = Uri.parse(urlApi);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<dynamic> getAllSupervisores() async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_ADMIN_ALL_SUPERVISORS']!;
    final url = Uri.parse(urlApi);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }

    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

//{"status":"200","message":"Origenes obtenidos","data":{"status":200,"output":[{"idorigen":"Fundacion Andrhani "},{"idorigen":"Rancho Perez"}]}}
  static Future<dynamic> getAllOriginsNames() async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_ADMIN_ALL_ORIGINS']!;
    final url = Uri.parse(urlApi);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data']['output'];
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

//{"status":"404","message":"No se encontraron lideres","data":{"status":404,"output":{"message":"No se encontro el lider"}}}
  static Future<dynamic> getAllLideresPorOrigen(String origen) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_ENCUESTADOR_ALL_LIDER_BY_ORIGIN']!;
    final url = Uri.parse("$urlApi/?origen=$origen");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );

    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data']['output'];
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<bool> deleteUsuario(String idUsuario) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_DELETE_ENCUESTADOR']!;
    final url = Uri.parse(urlApi);
    final response = await http.delete(
      body: json.encode({
        'id': idUsuario,
      }),
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );

    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<bool> uploadEncuestadorInfo(Map<String, dynamic> datos) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_UPLOAD_ENCUESTADOR_INFO']!;
    final url = Uri.parse(urlApi);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
      body: json.encode(datos),
    );

    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "201") {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<bool> updateEncuestadorInfo(Map<String, dynamic> datos) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_UPDATE_ENCUESTADOR_INFO']!;
    final url = Uri.parse(urlApi);
    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
      body: json.encode(datos),
    );

    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "201") {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<bool> updateEncuestadorPassword(
      Map<String, dynamic> datos) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_UPDATE_USER_PASSWORD']!;
    final url = Uri.parse(urlApi);
    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
      body: json.encode(datos),
    );

    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "201") {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<bool> uploadEncuesta(Map<String, dynamic> datos) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_UPLOAD_ENCUESTA']!;
    final url = Uri.parse(urlApi);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}"
      },
      body: json.encode(datos),
    );

    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "201") {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<dynamic> getAllResponsablesFiltradosOrigenLider(
      String origen, String lider) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_ADMIN_ALL_USERS']!;

    //?origen=Fundación%20ANDRHANI&lider=PRUEBA2
    final url = Uri.parse("$urlApi/?origen=$origen");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return false;
    }
  }

  static Future<dynamic> getAllEncuestasFiltradasOrigenLider(
      String origen, String lider) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_GET_ALL_ENCUESTAS']!;

    //?origen=Fundación%20ANDRHANI&lider=PRUEBA2
    final url = Uri.parse("$urlApi/?origen=$origen&lider=$lider");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<bool> verificacionDeRegistroHecho(String encuestador) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_GET_ENCUESTADOR_INFO']!;

    //?origen=Fundación%20ANDRHANI&lider=PRUEBA2
    final url = Uri.parse("$urlApi?id=$encuestador");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );

    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      //LLENAMOS LOS DATOS DEL USUARIO
      usuarioActivo!.setApellidoPaterno =
          jsonResponse['data']['output'][0]['apellido_paterno'];
      usuarioActivo!.setApellidoMaterno =
          jsonResponse['data']['output'][0]['apellido_materno'];
      usuarioActivo!.setNombre = jsonResponse['data']['output'][0]['nombre'];
      usuarioActivo!.setDomicilio =
          jsonResponse['data']['output'][0]['domicilio'];
      usuarioActivo!.setNoExt = jsonResponse['data']['output'][0]['no_ext'];
      usuarioActivo!.setNoInt = jsonResponse['data']['output'][0]['no_int'];
      usuarioActivo!.setFraccionamiento =
          jsonResponse['data']['output'][0]['fraccionamiento'];
      usuarioActivo!.setDistrito =
          jsonResponse['data']['output'][0]['distrito'];
      usuarioActivo!.setOrigen =
          jsonResponse['data']['output'][0]['origen_idorigen'];
      usuarioActivo!.setSeccion = jsonResponse['data']['output'][0]['seccion'];
      usuarioActivo!.setFechaNacimiento =
          DateTime.parse(jsonResponse['data']['output'][0]['fecha_nacimiento'])
              .toIso8601String()
              .split("T")[0];

      usuarioActivo!.setTelefono =
          jsonResponse['data']['output'][0]['telefono'];
      usuarioActivo!.setCelular = jsonResponse['data']['output'][0]['celular'];
      usuarioActivo!.setPerfilDeFacebook =
          jsonResponse['data']['output'][0]['perfil_facebook'];
      usuarioActivo!.setClaveDeElector =
          jsonResponse['data']['output'][0]['clave_elector'];
      usuarioActivo!.setIdLider =
          jsonResponse['data']['output'][0]['lider_idlider'];
      return true;
    } else if (jsonResponse['status'] == "404") {
      Fluttertoast.showToast(
          msg: "Registra tus datos personales primero para comenzar");
      return false;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse['message'] ??
              "Ocurrió un problema con el servidor, intente más tarde");
      return false;
    }
  }

  static Future<dynamic> getAllEncuestas() async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_GET_ALL_ENCUESTAS']!;

    //?origen=Fundación%20ANDRHANI&lider=PRUEBA2
    final url = Uri.parse(urlApi);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return false;
    }
  }

  static Future<dynamic> getAllEncuestasOrigen(String origen) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_GET_ALL_ENCUESTAS']!;

    //?origen=Fundación%20ANDRHANI&lider=PRUEBA2
    final url = Uri.parse("$urlApi/?origen=$origen");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return false;
    }
  }

  static Future<dynamic> getAllEncuestasOrigenLider(
      String origen, String lider) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_GET_ALL_ENCUESTAS']!;

    //?origen=Fundación%20ANDRHANI&lider=PRUEBA2
    final url = Uri.parse("$urlApi/?origen=$origen&lider=$lider");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return false;
    }
  }

  static Future<dynamic> getAllDistritosYEncuestas() async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_GET_DISTRITOS_Y_ENCUESTAS']!;

    //?origen=Fundación%20ANDRHANI&lider=PRUEBA2
    final url = Uri.parse(urlApi);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return false;
    }
  }

  static Future<dynamic> getAllResponsablesByDistrito(String distrito) async {
    await dotenv.load(fileName: '.env');

    String urlApi = dotenv.env['URL_API_GET_RESPONSABLES_BY_DISTRITIO']!;

    //?origen=Fundación%20ANDRHANI&lider=PRUEBA2
    final url = Uri.parse("$urlApi?distrito=$distrito");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "authorization": "${usuarioActivo!.token}",
      },
    );
    if (response.body.startsWith("<")) {
      Fluttertoast.showToast(
          msg: "Ha ocurrido un error interno, intentar más tarde");
      return false;
    }
    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == "200") {
      return jsonResponse['data'];
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      return false;
    }
  }
}
