import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawerAdmin extends StatefulWidget {
  const CustomDrawerAdmin({
    super.key,
  });

  @override
  State<CustomDrawerAdmin> createState() => _CustomDrawerAdminState();
}

//CON ESTE ELEMENTO PODEMOS MODIFICAR EL ESTILO DE TODOS LOS TEXTOS DEL DRAWER
TextStyle estiloTexto2 =
    const TextStyle(color: Color(0xFFE6AB44), fontSize: 22);

class _CustomDrawerAdminState extends State<CustomDrawerAdmin> {
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
            Visibility(
              visible: usuarioActivo!.role == "admin",
              child: TextButton(
                  onPressed: () {
                    context.push("/admin_home_screen/create_user_screen");
                  },
                  child: Text("CREAR USUARIO", style: estiloTexto2)),
            ),
            Visibility(
              visible: usuarioActivo!.role == "admin",
              child: const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  color: Colors.black,
                ),
              ),
            ),
            Visibility(
              visible: usuarioActivo!.role == "admin",
              child: TextButton(
                  onPressed: () {
                    context
                        .push("/admin_home_screen/responsables_de_red_screen");
                  },
                  child: Text("RESPONSABLES DE RED", style: estiloTexto2)),
            ),
            Visibility(
              visible: usuarioActivo!.role == "admin",
              child: const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  color: Colors.black,
                ),
              ),
            ),
            Visibility(
              visible: usuarioActivo!.role == "admin",
              child: TextButton(
                  onPressed: () {
                    context.push("/admin_home_screen/export_networks");
                  },
                  child: Text("EXPORTAR REDES", style: estiloTexto2)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                color: Colors.black,
              ),
            ),
            TextButton(
                onPressed: () {
                  context.push("/distritos_screen");
                },
                child: Text("DISTRITOS", style: estiloTexto2)),
            Visibility(
              visible: usuarioActivo!.role == "admin",
              child: const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  color: Colors.black,
                ),
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
                child: Text("CERRAR SESIÓN", style: estiloTexto2)),
          ],
        ),
      ),
    );
  }
}
