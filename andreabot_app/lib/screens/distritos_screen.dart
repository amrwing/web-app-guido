import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class DistritosScreen extends StatefulWidget {
  const DistritosScreen({super.key});

  @override
  State<DistritosScreen> createState() => _DistritosScreenState();
}

class _DistritosScreenState extends State<DistritosScreen> {
  bool pantallaCargando = true;
  List<Map<String, dynamic>> distritos = [];
  @override
  void initState() {
    super.initState();
    ApiRequests.getAllDistritosYEncuestas().then((value) {
      if (value is List) {
        for (var element in value) {
          distritos.add(element);
        }
        setState(() {
          pantallaCargando = false;
        });
      } else {
        Fluttertoast.showToast(msg: "Sección no disponible de momento");
      }
    });
  }

  final bool canPop = (usuarioActivo!.role == "admin") ? true : false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        //CUADRO DE CONFIRMACIÓN DE CERRAR APP
        if (usuarioActivo!.role != "admin") {
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
                                      minimumSize: MaterialStatePropertyAll(
                                          Size(80, 30)),
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
                                      minimumSize: MaterialStatePropertyAll(
                                          Size(80, 30)),
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
        }
      },
      child: Scaffold(
        endDrawer: const CustomDrawerAdmin(),
        appBar: CustomAppBar(),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "DISTRITOS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFBC7027),
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
              (pantallaCargando)
                  ? const Padding(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 50, right: 50),
                      child: CircularProgressIndicator(
                        color: Color(0xFFE6AB44),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: distritos.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              context.push(
                                  "/distritos_screen/responsables_por_distrito_screen",
                                  extra:
                                      distritos[index]['distrito'] as String);
                            },
                            child: Card(
                                color: const Color(0xFFfee7ca),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Distrito ${distritos[index]['distrito']} ",
                                        style: const TextStyle(
                                            color: Color(0xFFbc7027),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Encuestas ${distritos[index]['total_capturas']}"),
                                          Text((distritos[index]
                                                  ['ultima_captura'] is String)
                                              ? "${distritos[index]['ultima_captura'].split("T")[1].split("Z")[0].split(".")[0]} ${(DateTime.now().difference(DateTime.parse(distritos[index]['ultima_captura'])).inDays > 1) ? "(Hace ${DateTime.now().difference(DateTime.parse(distritos[index]['ultima_captura'])).inDays} días)" : (DateTime.now().difference(DateTime.parse(distritos[index]['ultima_captura'])).inHours < 24) ? "Hoy" : "Ayer"}  "
                                              : "No disponible")
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
