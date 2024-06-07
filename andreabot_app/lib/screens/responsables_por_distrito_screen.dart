import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ResponsablesPorDistritoScreen extends StatefulWidget {
  const ResponsablesPorDistritoScreen({super.key, required this.distrito});
  final String distrito;
  @override
  State<ResponsablesPorDistritoScreen> createState() =>
      _ResponsablesPorDistritoScreenState();
}

class _ResponsablesPorDistritoScreenState
    extends State<ResponsablesPorDistritoScreen> {
  List<Map<String, dynamic>> todosLosResponsables = [];
  List<Map<String, dynamic>> todosLosResponsablesTemp = [];
  List<Map<String, dynamic>> usuariosBuscados = [];
  TextEditingController busquedaTextController = TextEditingController();
  bool pantallaCargando = true;
  @override
  void initState() {
    ApiRequests.getAllResponsablesByDistrito(widget.distrito).then((value) {
      if (value is List) {
        for (var val in value) {
          todosLosResponsables.add(val);
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
        if (element['nombre'].contains(idUsuario) ||
            element['apellido_paterno'].contains(idUsuario)) {
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
      //TODO: CAMBIAR EL DRAWER EN CASO DE QUE EL USUARIO SEA SUPERVISOR
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
            Text(
              "DISTRITO ${widget.distrito.toString()}",
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                        child: InkWell(
                          onTap: () {
                            todosLosResponsables[index]["distrito"] =
                                widget.distrito.toString();
                            context.push(
                                "/distritos_screen/responsables_por_distrito_screen/user_information_screen",
                                extra: todosLosResponsables[index]);
                          },
                          child: Card(
                              color: const Color(0xFFfee7ca),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${todosLosResponsables[index]['nombre']} ${todosLosResponsables[index]['apellido_paterno']}",
                                      style: const TextStyle(
                                          color: Color(0xFFbc7027),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    (todosLosResponsables[index]
                                                ['total_capturas'] !=
                                            null)
                                        ? Text(
                                            "${todosLosResponsables[index]['total_capturas']}")
                                        : const Text(""),
                                    Text((todosLosResponsables[index]
                                            ['ultima_captura'] is String)
                                        ? "${(DateTime.now().difference(DateTime.parse(todosLosResponsables[index]['ultima_captura'])).inDays > 1) ? "(Hace ${DateTime.now().difference(DateTime.parse(todosLosResponsables[index]['ultima_captura'])).inDays} días)" : (DateTime.now().difference(DateTime.parse(todosLosResponsables[index]['ultima_captura'])).inHours < 24) ? "Hoy" : "Ayer"}  "
                                        : "No disponible")
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
