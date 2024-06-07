import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawerEncuestador extends StatefulWidget {
  const CustomDrawerEncuestador({
    super.key,
  });

  @override
  State<CustomDrawerEncuestador> createState() =>
      _CustomDrawerEncuestadorState();
}

//CON ESTE ELEMENTO PODEMOS MODIFICAR EL ESTILO DE TODOS LOS TEXTOS DEL DRAWER
TextStyle estiloTexto1 =
    const TextStyle(color: Color(0xFFE6AB44), fontSize: 22);

class _CustomDrawerEncuestadorState extends State<CustomDrawerEncuestador> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color(0xFFFCFCF5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 40, bottom: 100, left: 15),
                child: Text(
                  "MENÚ",
                  style: TextStyle(
                      color: Color(0xFF9A652F),
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                color: Colors.black,
              ),
            ),
            TextButton(
                onPressed: () async {
                  context.push("/responsable_de_red/datos_personales");
                },
                child: Text("DATOS PERSONALES", style: estiloTexto1)),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                color: Colors.black,
              ),
            ),
            TextButton(
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
                child: Text("INICIAR CAPTURA", style: estiloTexto1)),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                color: Colors.black,
              ),
            ),
            TextButton(
                onPressed: () {
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
                                      "CERRAR SESIÓN",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0, right: 20.0, left: 20.0),
                                    child: Text(
                                      "¿ESTÁS SEGURO DE QUE DESEAS CERRAR SESIÓN?",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xFFE6AB44)),
                                              minimumSize:
                                                  MaterialStatePropertyAll(
                                                      Size(80, 30)),
                                              maximumSize:
                                                  MaterialStatePropertyAll(
                                                      Size(100, 50))),
                                          onPressed: () {
                                            appRouter.go("/");
                                            datosRegistrados = false;
                                          },
                                          child: const Center(
                                              child: Text(
                                            "Sí",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xFFE6AB44)),
                                              minimumSize:
                                                  MaterialStatePropertyAll(
                                                      Size(80, 30)),
                                              maximumSize:
                                                  MaterialStatePropertyAll(
                                                      Size(100, 50))),
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: const Center(
                                              child: Text(
                                            "No",
                                            style:
                                                TextStyle(color: Colors.white),
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
                child: Text("CERRAR SESIÓN", style: estiloTexto1)),
          ],
        ),
      ),
    );
  }
}
