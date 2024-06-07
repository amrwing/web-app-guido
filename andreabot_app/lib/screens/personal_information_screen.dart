import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final TextEditingController textOrigen = TextEditingController();
  final TextEditingController textLider = TextEditingController();
  bool estadoOrigen = true;
  bool estadoLider = true;

  List<String> questions = [
    'Apellido paterno',
    'Apellido materno',
    'Nombre',
    'Domicilio',
    'No. exterior',
    'No interior',
    'Fraccionamiento',
    'Distrito',
    'Sección',
    'Fecha de nacimiento',
    'Teléfono',
    'Celular',
    'Perfil de Facebook',
    'Clave de elector'
  ];
  List<String> idQuestions = [
    "id",
    "apellido_paterno",
    "apellido_materno",
    "nombre",
    "domicilio",
    "no_ext",
    "no_int",
    "fraccionamiento",
    "distrito",
    "seccion",
    "fecha_nacimiento",
    "telefono",
    "celular",
    "perfil_facebook",
    "clave_elector",
    "lider"
  ];
  List<int> tipos = [1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, 1, 1];
  List<bool> estados = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  List<TextEditingController> textControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  void respuestas(BuildContext context) async {
    Map<String, dynamic> parametros = {};
    setState(() {
      for (int i = 0; i < questions.length; i++) {
        if (textControllers[i].text == '') {
          estados[i] = false;
        } else {
          estados[i] = true;
        }
      }

      if (textOrigen.text == '') {
        estadoOrigen = false;
      } else {
        estadoOrigen = true;
      }

      if (textLider.text == '') {
        estadoLider = false;
      } else {
        estadoLider = true;
      }

      //extras validar tamaños ()
    });
    if (estados.contains(false) ||
        estadoOrigen == false ||
        estadoLider == false) {
      Fluttertoast.showToast(msg: "Hay campos sin contestar");
      return;
    } else {
      //CONSTRUIMOS EL BODY PARA LA API
      parametros['id'] = usuarioActivo!.usuario;
      for (int i = 0; i < idQuestions.length; i++) {
        if (idQuestions[i] != "id" && idQuestions[i] != "lider") {
          parametros[idQuestions[i]] = textControllers[i - 1].text.trim();
        }
      }
      parametros['lider'] = textLider.text.trim();
      //LLAMAR A LA API PARA GUARDAR
      showAdaptiveDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFE6AB44),
          ),
        ),
      );
      final bool respuesta =
          await ApiRequests.uploadEncuestadorInfo(parametros);
      if (context.mounted) {
        context.pop();
      }
      if (respuesta) {
        for (int i = 0; i < textControllers.length; i++) {
          textControllers[i].text = "";
        }
        datosRegistrados = true;
      }
    }
  }

  void respuestasActualizadas(BuildContext context) async {
    Map<String, dynamic> parametros = {};
    setState(() {
      //TODO: Guardar toda la informacion
      for (int i = 0; i < questions.length; i++) {
        if (textControllers[i].text == '') {
          estados[i] = false;
        } else {
          estados[i] = true;
        }
      }

      if (textOrigen.text == '') {
        estadoOrigen = false;
      } else {
        estadoOrigen = true;
      }

      if (textLider.text == '') {
        estadoLider = false;
      } else {
        estadoLider = true;
      }

      //extras validar tamaños ()
    });
    if (estados.contains(false) ||
        estadoOrigen == false ||
        estadoLider == false) {
      Fluttertoast.showToast(msg: "Hay campos sin contestar");
      return;
    } else {
      //CONSTRUIMOS EL BODY PARA LA API
      parametros['id'] = usuarioActivo!.usuario;
      for (int i = 0; i < idQuestions.length; i++) {
        if (idQuestions[i] != "id" && idQuestions[i] != "lider") {
          parametros[idQuestions[i]] = textControllers[i - 1].text.trim();
        }
      }
      parametros['lider'] = textLider.text.trim();
      //TODO: LLAMAR A LA API PARA GUARDAR
      showAdaptiveDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFE6AB44),
          ),
        ),
      );
      final bool respuesta =
          await ApiRequests.updateEncuestadorInfo(parametros);
      if (context.mounted) {
        context.pop();
      }
      if (respuesta) {
        if (context.mounted) {
          context.pop();
        }
      }
    }
  }

  //TODO: ESTAS LISTSA SE LLENARAN DINAMICAMENTE A PETICIÓN DE LA API
  bool _status1 = false;
  bool _status2 = true;
  List<DropdownMenuEntry<dynamic>> origenes = [];
  List<DropdownMenuEntry<dynamic>> lider = [];
  bool pantallaCargando = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!datosRegistrados) {
      if (usuarioActivo!.getLider == null) {
        ApiRequests.verificacionDeRegistroHecho(usuarioActivo!.usuario).then(
          (value) {
            if (value) {
              textControllers[0].text = usuarioActivo!.getApellidoPaterno;
              textControllers[1].text = usuarioActivo!.getApellidoMaterno;
              textControllers[2].text = usuarioActivo!.getNombre;
              textControllers[3].text = usuarioActivo!.getDomicilio;
              textControllers[4].text = usuarioActivo!.getNoExt;
              textControllers[5].text = usuarioActivo!.getNoInt;
              textControllers[6].text = usuarioActivo!.getFraccionamiento;
              textControllers[7].text = usuarioActivo!.getDistrito;
              textControllers[8].text = usuarioActivo!.getSeccion;
              textControllers[9].text = usuarioActivo!.getFechaNacimiento;
              textControllers[10].text = usuarioActivo!.getTelefono;
              textControllers[11].text = usuarioActivo!.getCelular;
              textControllers[12].text = usuarioActivo!.getPerfilDeFacebook;
              textControllers[13].text = usuarioActivo!.getClaveDeElector;
              textLider.text = usuarioActivo!.getLider;
              textOrigen.text = usuarioActivo!.getOrigen;
              datosRegistrados = true;
              setState(() {
                pantallaCargando = false;
              });
            } else {
              pantallaCargando = false;
            }
            ApiRequests.getAllOriginsNames().then((respuesta) {
              if (respuesta is List) {
                for (var value in respuesta) {
                  origenes.add(
                    DropdownMenuEntry(
                        value: value['idorigen'].toString().toUpperCase(),
                        label: value['idorigen'].toString().toUpperCase()),
                  );
                }
                setState(() {
                  _status1 = true;
                });
              } else {
                context.pop();
                Fluttertoast.showToast(
                    msg: "Servicio no disponible, intentelo más tarde");
              }
            });
          },
        );
      }
    } else {
      textControllers[0].text = usuarioActivo!.getApellidoPaterno;
      textControllers[1].text = usuarioActivo!.getApellidoMaterno;
      textControllers[2].text = usuarioActivo!.getNombre;
      textControllers[3].text = usuarioActivo!.getDomicilio;
      textControllers[4].text = usuarioActivo!.getNoExt;
      textControllers[5].text = usuarioActivo!.getNoInt;
      textControllers[6].text = usuarioActivo!.getFraccionamiento;
      textControllers[7].text = usuarioActivo!.getDistrito;
      textControllers[8].text = usuarioActivo!.getSeccion;
      textControllers[9].text = usuarioActivo!.getFechaNacimiento;
      textControllers[10].text = usuarioActivo!.getTelefono;
      textControllers[11].text = usuarioActivo!.getCelular;
      textControllers[12].text = usuarioActivo!.getPerfilDeFacebook;
      textControllers[13].text = usuarioActivo!.getClaveDeElector;
      textLider.text = usuarioActivo!.getLider;
      textOrigen.text = usuarioActivo!.getOrigen;
      setState(() {
        pantallaCargando = false;
      });
      ApiRequests.getAllOriginsNames().then((respuesta) {
        if (respuesta is List) {
          for (var value in respuesta) {
            origenes.add(
              DropdownMenuEntry(
                  value: value['idorigen'].toString().toUpperCase(),
                  label: value['idorigen'].toString().toUpperCase()),
            );
          }
          setState(() {
            _status1 = true;
          });
        } else {
          context.pop();
          Fluttertoast.showToast(
              msg: "Servicio no disponible, intentelo más tarde");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawerEncuestador(),
      appBar: CustomAppBar(),
      body: Center(
        child: (!pantallaCargando)
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Titulo
                    const Padding(
                      padding: EdgeInsets.only(bottom: 35),
                      child: Column(
                        children: [
                          Text(
                            "RED",
                            style: TextStyle(
                                color: Color(0xFFBC7027),
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "RESPONSABLE DE RED",
                              style: TextStyle(
                                color: Color(0xFFBC7027),
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Formulario Inicial

                    Form(
                      child: Column(
                        children: [
                          (_status1)
                              ? DropdownMenu(
                                  onSelected: (origenSeleccionado) async {
                                    //PRIMERO VACIAMOS LA LISTA
                                    lider = [];
                                    setState(() {
                                      _status2 = false;
                                    });
                                    //TODO ACTUALIZAR LOS LIDERES PARA ESE ORIGEN
                                    final respuesta = await ApiRequests
                                        .getAllLideresPorOrigen(
                                            origenSeleccionado);
                                    if (respuesta is List) {
                                      for (var value in respuesta) {
                                        lider.add(
                                          DropdownMenuEntry(
                                              value: value['idlider'],
                                              label: value['idlider']),
                                        );
                                      }
                                      setState(() {
                                        _status2 = true;
                                      });
                                    } else {
                                      setState(() {
                                        _status2 = true;
                                      });
                                    }
                                  },
                                  width: 300,
                                  hintText: "ORIGEN",
                                  controller: textOrigen,
                                  dropdownMenuEntries: origenes,
                                  textStyle:
                                      const TextStyle(color: Color(0xFF9A652F)),
                                  inputDecorationTheme: InputDecorationTheme(
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: estadoOrigen
                                          ? const Color(0xFF9A652F)
                                          : Colors.red,
                                    ),
                                    fillColor: const Color(0xFFE6AB44),
                                    focusColor: const Color(0xFFE6AB44),
                                    hoverColor: const Color(0xFFE6AB44),
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, bottom: 20, left: 50, right: 50),
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFE6AB44),
                                  ),
                                ),
                          (_status2)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 50, right: 50),
                                  child: DropdownMenu(
                                    width: 300,
                                    hintText: "LIDER",
                                    controller: textLider,
                                    dropdownMenuEntries: lider,
                                    textStyle: const TextStyle(
                                        color: Color(0xFF9A652F)),
                                    inputDecorationTheme: InputDecorationTheme(
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: estadoLider
                                            ? const Color(0xFF9A652F)
                                            : Colors.red,
                                      ),
                                      fillColor: const Color(0xFFE6AB44),
                                      focusColor: const Color(0xFFE6AB44),
                                      hoverColor: const Color(0xFFE6AB44),
                                    ),
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, bottom: 20, left: 50, right: 50),
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFE6AB44),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Form(
                      child: Column(
                        children: List.generate(
                          questions.length,
                          (index) => Question(
                            text: questions[index],
                            eC: textControllers[index],
                            tipo: tipos[index],
                            estado: estados[index],
                          ),
                        ),
                      ),
                    ),
                    (!datosRegistrados)
                        ? CustomElevatedButton(
                            text: 'GUARDAR DATOS',
                            onPressed: () => respuestas(context))
                        : CustomElevatedButton(
                            text: 'ACTUALIZAR DATOS',
                            onPressed: () => respuestasActualizadas(context))
                  ],
                ),
              )
            : const CircularProgressIndicator(
                color: Color(0xFFE6AB44),
              ),
      ),
    );
  }
}
