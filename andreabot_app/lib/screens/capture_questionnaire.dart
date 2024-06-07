import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/routes/routes.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CaptureQuestionnaire extends StatefulWidget {
  const CaptureQuestionnaire({super.key});

  @override
  State<CaptureQuestionnaire> createState() => _CaptureQuestionnaireState();
}

class _CaptureQuestionnaireState extends State<CaptureQuestionnaire> {
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
  ];

  List<int> tipos = [1, 1, 1, 1, 3, 1, 1, 3, 3, 2, 3, 3, 1, 1];
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

  Future<void> validarSubir(BuildContext context) async {
    Map<String, dynamic> parametros = {};
    setState(() {
      for (int i = 0; i < questions.length; i++) {
        if (textControllers[i].text.trim() == '') {
          estados[i] = false;
        } else {
          estados[i] = true;
        }
      }
    });
    if (estados.contains(false)) {
      return;
    } else {
      //Guardar info
      //CONSTRUIMOS EL BODY PARA LA API
      for (int i = 0; i < idQuestions.length; i++) {
        parametros[idQuestions[i]] = textControllers[i].text.trim();
      }
      parametros['id_responsable'] = usuarioActivo!.usuario;
      showAdaptiveDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFE6AB44),
          ),
        ),
      );
      final bool respuesta = await ApiRequests.uploadEncuesta(parametros);
      if (context.mounted) {
        context.pop();
      }
      if (respuesta) {
        for (int i = 0; i < textControllers.length; i++) {
          textControllers[i].text = "";
        }
        appRouter.pushReplacement("/responsable_de_red/final_captura");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawerEncuestador(),
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Titulo
              const Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: Column(
                  children: [
                    Text(
                      "CAPTURA",
                      style: TextStyle(
                          color: Color(0xFFBC7027),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              //Formulario
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
              CustomElevatedButton(
                  text: 'GUARDAR DATOS', onPressed: () => validarSubir(context))
            ],
          ),
        ),
      ),
    );
  }
}
