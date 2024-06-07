import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

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
        endDrawer: const CustomDrawerAdmin(),
        appBar: CustomAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: Text(
                  "ADMINISTRADOR",
                  style: TextStyle(
                      color: Color(0xFFBC7027),
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
              CustomElevatedButton(
                text: "CREAR USUARIO",
                onPressed: () {
                  context.push("/admin_home_screen/create_user_screen");
                },
              ),
              CustomElevatedButton(
                text: "RESPONSABLES DE RED",
                onPressed: () {
                  context.push("/admin_home_screen/responsables_de_red_screen");
                },
              ),
              CustomElevatedButton(
                text: "SUPERVISORES",
                onPressed: () {
                  context.push("/admin_home_screen/supervisores_screen");
                },
              ),
              CustomElevatedButton(
                text: "EXPORTAR REDES",
                onPressed: () {
                  context.push("/admin_home_screen/export_networks");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
