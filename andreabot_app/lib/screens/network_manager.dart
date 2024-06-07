import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class NetworkManager extends StatelessWidget {
  const NetworkManager({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        //CUADRO DE CONFIRMACIÓN DE CERRAR APP
        showAdaptiveDialog(
            context: context,
            builder: (context) => Center(
                    child: Card(
                        child: SingleChildScrollView(
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, right: 20.0, left: 20.0),
                          child: Text(
                            "SALIR",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, right: 20.0, left: 20.0),
                          child: Text(
                            "¿ESTÁS SEGURO DE QUE DESEAS SALIR?",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFFE6AB44)),
                                    minimumSize:
                                        MaterialStatePropertyAll(Size(80, 30)),
                                    maximumSize: MaterialStatePropertyAll(
                                        Size(100, 50))),
                                onPressed: () {
                                  SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop');
                                },
                                child: const Center(
                                    child: Text(
                                  "Sí",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFFE6AB44)),
                                    minimumSize:
                                        MaterialStatePropertyAll(Size(80, 30)),
                                    maximumSize: MaterialStatePropertyAll(
                                        Size(100, 50))),
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Center(
                                    child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ))));
      },
      child: Scaffold(
        endDrawer: const CustomDrawerEncuestador(),
        appBar: CustomAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              CustomElevatedButton(
                text: "DATOS PERSONALES",
                onPressed: () {
                  context.push("/responsable_de_red/datos_personales");
                },
              ),
              CustomElevatedButton(
                text: "INICIAR CAPTURA",
                onPressed: () async {
                  //SOLO SE REALIZA LA CONSULTA LA PRIMERA VEZ
                  if (!datosRegistrados) {
                    showAdaptiveDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFE6AB44),
                        ),
                      ),
                    );
                    final respuesta =
                        await ApiRequests.verificacionDeRegistroHecho(
                            usuarioActivo!.usuario);
                    if (respuesta) {
                      if (context.mounted) {
                        //CAMBIAMOS LA VARIABLE GLOBAL.
                        datosRegistrados = true;
                        context.pop();
                        context
                            .push("/responsable_de_red/cuestionario_captura");
                      } else {
                        if (context.mounted) {
                          context.pop();
                        }
                      }
                    } else {
                      if (context.mounted) {
                        context.pop();
                      }
                    }
                  } else {
                    if (context.mounted) {
                      context.push("/responsable_de_red/cuestionario_captura");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
