import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/global/global.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class SupervisoresScreen extends StatefulWidget {
  const SupervisoresScreen({super.key});

  @override
  State<SupervisoresScreen> createState() => _SupervisoresScreenState();
}

class _SupervisoresScreenState extends State<SupervisoresScreen> {
  List<Map<String, dynamic>> todosLosResponsables = [];
  List<Map<String, dynamic>> todosLosResponsablesTemp = [];
  List<Map<String, dynamic>> todosLosSupervisores = [];
  List<Map<String, dynamic>> usuariosBuscados = [];
  TextEditingController busquedaTextController = TextEditingController();
  bool pantallaCargando = true;
  @override
  void initState() {
    ApiRequests.getAllSupervisores().then((value) {
      if (value is List) {
        for (var val in value) {
          if (val['id_usuario'] != usuarioActivo!.usuario) {
            if (val['activo'] == 1) {
              todosLosResponsables.add(val);
            }
          }
        }
        setState(() {
          pantallaCargando = false;
        });
      } else {
        context.pop();
        Fluttertoast.showToast(msg: "Sección no disponible de momento");
      }
    });
    super.initState();
  }

  bool modoBusqueda = false;
  final focusNode = FocusNode();
  void buscarUsuarios(String idUsuario) {
    if (idUsuario.trim().isNotEmpty && idUsuario.trim().length > 1) {
      modoBusqueda = true;
      if (todosLosResponsables.isNotEmpty &&
          todosLosResponsablesTemp.length <= todosLosResponsables.length) {
        todosLosResponsablesTemp = todosLosResponsables;
      } else {
        todosLosResponsables = todosLosResponsablesTemp;
      }
      todosLosResponsables = [];
      for (var element in todosLosResponsablesTemp) {
        if (element['id_usuario'].contains(idUsuario)) {
          todosLosResponsables.add(element);
        }
      }
    } else {
      modoBusqueda = false;
      setState(() {
        if (todosLosResponsablesTemp.isNotEmpty) {
          todosLosResponsables = todosLosResponsablesTemp;
          todosLosResponsablesTemp = [];
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawerAdmin(),
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 40, bottom: 10),
              child: TextField(
                controller: busquedaTextController,
                onChanged: (value) => buscarUsuarios(value),
                onTapOutside: (event) => focusNode.unfocus(),
                focusNode: focusNode,
                decoration: InputDecoration(
                  prefixIconColor: const Color(0xFFE6AB44),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      //TODO: FUNCION PARA BUSCAR A RESPONSABLE DE RED POR NOMBRE
                    },
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE6AB44),
                    ),
                  ),
                  border:
                      const OutlineInputBorder(borderRadius: BorderRadius.zero),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF9A652F),
                  ),
                  fillColor: const Color(0xFFE6AB44),
                  hintText: "BUSCAR",
                  focusColor: const Color(0xFFE6AB44),
                  hoverColor: const Color(0xFFE6AB44),
                ),
              ),
            ),
            const Text(
              "SUPERVISORES",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFFBC7027),
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            //AQUI MOSTRAMOS UN CIRCULO DE CARGA O LA LISTA DE RESPONSABLES EN CASO DE QUE YA HAYAN CARGADO TODOS, ESTA VARIABLE LA USAREMOS PARA CUANDO CARGUE
            //POR PRIMERA VEZ
            (pantallaCargando)
                ? const Padding(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 50, right: 50),
                    child: CircularProgressIndicator(
                      color: Color(0xFFE6AB44),
                    ),
                  )
                :
                //ENTONCES PONDREMOS LA CARGA DE PERSONAS
                Expanded(
                    child: ListView.builder(
                      itemCount: todosLosResponsables.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 10),
                        child: Card(
                            color: const Color(0xFFfee7ca),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${todosLosResponsables[index]['id_usuario']} ",
                                        style: const TextStyle(
                                            color: Color(0xFFbc7027),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      (todosLosResponsables[index]
                                                      ['total_capturas'] !=
                                                  null &&
                                              todosLosResponsables[index]
                                                      ['total_capturas'] !=
                                                  0)
                                          ? Text(
                                              "Encuestas ${todosLosResponsables[index]['total_capturas']}")
                                          : const Text("No hay encuestas")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFffde59),
                                              shape: const CircleBorder(
                                                  side: BorderSide.none)),
                                          onPressed: () async {
                                            //EDITAR USUARIO
                                            //TODO HACER PANTALLA DE EDICIÓN DE USUARIO
                                            final bool? res =
                                                await showAdaptiveDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => Center(
                                                              child: Card(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 300,
                                                                    height: 200,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 20.0,
                                                                              right: 20.0,
                                                                              left: 20.0),
                                                                          child:
                                                                              Text(
                                                                            "EDITAR USUARIO",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 20.0,
                                                                              right: 20.0,
                                                                              left: 20.0),
                                                                          child:
                                                                              Text(
                                                                            "¿ESTÁS SEGURO DE QUE DESEAS EDITAR ESTE USUARIO?",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                                                                              child: ElevatedButton(
                                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFE6AB44)), minimumSize: MaterialStatePropertyAll(Size(80, 30)), maximumSize: MaterialStatePropertyAll(Size(100, 50))),
                                                                                onPressed: () {
                                                                                  context.pop(true);
                                                                                },
                                                                                child: const Center(
                                                                                    child: Text(
                                                                                  "Sí",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                )),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                                                                              child: ElevatedButton(
                                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFE6AB44)), minimumSize: MaterialStatePropertyAll(Size(80, 30)), maximumSize: MaterialStatePropertyAll(Size(100, 50))),
                                                                                onPressed: () {
                                                                                  context.pop(false);
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
                                                                ),
                                                              ),
                                                            ));
                                            //SI SE PRESIONÓ QUE SÍ
                                            if (res != null && res) {
                                              if (context.mounted) {
                                                context.push(
                                                    '/admin_home_screen/responsables_de_red_screen/editar_usuario_screen',
                                                    extra: todosLosResponsables[
                                                        index]);
                                              }
                                            }
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xffed1d2b),
                                              shape: const CircleBorder(
                                                  side: BorderSide.none)),
                                          onPressed: () async {
                                            //ELIMINAR USUARIO

                                            final bool? res =
                                                await showAdaptiveDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => Center(
                                                              child: Card(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 300,
                                                                    height: 200,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 20.0,
                                                                              right: 20.0,
                                                                              left: 20.0),
                                                                          child:
                                                                              Text(
                                                                            "ELIMINAR USUARIO",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 20.0,
                                                                              right: 20.0,
                                                                              left: 20.0),
                                                                          child:
                                                                              Text(
                                                                            "¿ESTÁS SEGURO DE QUE DESEAS ELIMINAR ESTE USUARIO?",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                                                                              child: ElevatedButton(
                                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xffed1d2b)), minimumSize: MaterialStatePropertyAll(Size(80, 30)), maximumSize: MaterialStatePropertyAll(Size(100, 50))),
                                                                                onPressed: () {
                                                                                  context.pop(true);
                                                                                },
                                                                                child: const Center(
                                                                                    child: Text(
                                                                                  "Sí",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                )),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                                                                              child: ElevatedButton(
                                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFE6AB44)), minimumSize: MaterialStatePropertyAll(Size(80, 30)), maximumSize: MaterialStatePropertyAll(Size(100, 50))),
                                                                                onPressed: () {
                                                                                  context.pop(false);
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
                                                                ),
                                                              ),
                                                            ));
                                            if (res != null && res) {
                                              //PETICIÓN PARA ELIMINAR USUARIO
                                              if (context.mounted) {
                                                showAdaptiveDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Color(0xFFE6AB44),
                                                    ),
                                                  ),
                                                );
                                              }
                                              final bool val = await ApiRequests
                                                  .deleteUsuario(
                                                      todosLosResponsables[
                                                          index]['id_usuario']);
                                              if (val) {
                                                if (modoBusqueda) {
                                                  setState(() {
                                                    todosLosResponsablesTemp
                                                        .remove(
                                                            todosLosResponsables[
                                                                index]);
                                                    todosLosResponsables
                                                        .removeAt(index);
                                                  });
                                                } else {
                                                  setState(() {
                                                    todosLosResponsables
                                                        .removeAt(index);
                                                  });
                                                }
                                              }
                                              if (context.mounted) {
                                                context.pop();
                                              }
                                            }
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
