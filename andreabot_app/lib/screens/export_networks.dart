import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:andreabot_app/helper/export_excel.dart';

class ExportNetworks extends StatefulWidget {
  const ExportNetworks({super.key});

  @override
  State<ExportNetworks> createState() => _ExportNetworksState();
}

class _ExportNetworksState extends State<ExportNetworks> {
  final TextEditingController textOrigen = TextEditingController();
  final TextEditingController textLider = TextEditingController();
  final TextEditingController textReponsable = TextEditingController();

  //TODO: ESTAS LISTSA SE LLENARAN DINAMICAMENTE A PETICIÓN DE LA API
  bool _status1 = false;
  bool _status2 = true;
  bool _status3 = true;
  bool verFiltro2 = false;
  bool verFiltro3 = false;
  bool mostrarBotones = false;
  bool cargando = true;
  List<DropdownMenuEntry<dynamic>> origenes = [];
  List<DropdownMenuEntry<dynamic>> lider = [];
  List<DropdownMenuEntry<dynamic>> resposable = [];

  @override
  void initState() {
    super.initState();
    ApiRequests.getAllOriginsNames().then((respuesta) {
      if (respuesta is List) {
        origenes.add(const DropdownMenuEntry(
          value: 'TODOS',
          label: 'TODOS',
        ));
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

  Map<dynamic, dynamic> numeros = {};

  String origenNombre = '';
  String liderNombre = '';
  String responsableNombre = '';

  int caso = 10;

  void seleccionCaso() {
    //print(caso);
    if (caso == 1) {
      setState(() {
        cargando = false;
      });
      //todas las encuestas
      casoExcel1();
      setState(() {
        cargando = true;
      });
    }
    if (caso == 2) {
      //print(origenNombre);
      //Todas las encuestas con el filtro de origen
      setState(() {
        cargando = false;
      });
      casoExcel2(origenNombre);
      setState(() {
        cargando = true;
      });
    }
    if (caso == 3) {
      //print(origenNombre);
      //print(liderNombre);
      //print(numeros[liderNombre]);
      //Todas las encuestas con el filtro de origen y lider
      setState(() {
        cargando = false;
      });
      casoExcel3(origenNombre, liderNombre, numeros[liderNombre]);
      setState(() {
        cargando = true;
      });
    }
    if (caso == 4) {
      //print(origenNombre);
      //print(liderNombre);
      //print(numeros[liderNombre]);
      //print(responsableNombre);
      //Todas las encuestas con el filtro de origen, lider y responsable
      setState(() {
        cargando = false;
      });
      casoExcel4(
          origenNombre, liderNombre, numeros[liderNombre], responsableNombre);
      setState(() {
        cargando = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawerAdmin(),
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: Column(
                  children: [
                    Text(
                      "EXPORTAR  REDES",
                      style: TextStyle(
                          color: Color(0xFFBC7027),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Form(
                child: Column(
                  children: [
                    (_status1)
                        ? DropdownMenu(
                            onSelected: (origenSeleccionado) async {
                              //PRIMERO VACIAMOS LA LISTA
                              if (origenSeleccionado == 'TODOS') {
                                setState(() {
                                  caso = 1;
                                  mostrarBotones = true;
                                  verFiltro2 = false;
                                  verFiltro3 = false;
                                  textLider.clear();
                                  textReponsable.clear();
                                });
                                //No desplegar los otros filtros
                                //Mostrar botones
                              } else {
                                numeros = {};
                                lider = [];
                                resposable = [];
                                setState(() {
                                  textLider.clear();
                                  textReponsable.clear();
                                  verFiltro2 = true;
                                  verFiltro3 = false;
                                  _status2 = false;
                                  origenNombre = '$origenSeleccionado';
                                  mostrarBotones = false;
                                });
                                final respuesta =
                                    await ApiRequests.getAllLideresPorOrigen(
                                        origenSeleccionado);
                                if (respuesta is List) {
                                  lider.add(
                                    const DropdownMenuEntry(
                                        value: 'TODOS', label: 'TODOS'),
                                  );
                                  for (var value in respuesta) {
                                    lider.add(
                                      DropdownMenuEntry(
                                          value: value['idlider'],
                                          label: value['idlider']),
                                    );
                                    String id = value['idlider'];
                                    String num = value['telefono'];
                                    numeros[id] = num;
                                  }
                                  setState(() {
                                    _status2 = true;
                                    //Mostrar el otro filtro
                                  });
                                } else {
                                  setState(() {
                                    _status2 = true;
                                  });
                                }
                              }
                            },
                            width: 300,
                            hintText: "ORIGEN",
                            controller: textOrigen,
                            dropdownMenuEntries: origenes,
                            textStyle:
                                const TextStyle(color: Color(0xFF9A652F)),
                            inputDecorationTheme: const InputDecorationTheme(
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF9A652F)),
                              fillColor: Color(0xFFE6AB44),
                              focusColor: Color(0xFFE6AB44),
                              hoverColor: Color(0xFFE6AB44),
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
                        ? Visibility(
                            visible: verFiltro2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 0, left: 50, right: 50),
                              child: DropdownMenu(
                                onSelected: (liderSeleccionado) async {
                                  if (liderSeleccionado == 'TODOS') {
                                    setState(() {
                                      caso = 2;
                                      mostrarBotones = true;
                                      verFiltro3 = false;
                                      textReponsable.clear();
                                    });
                                  } else {
                                    resposable = [];
                                    setState(() {
                                      textReponsable.clear();
                                      _status3 = false;
                                      mostrarBotones = false;
                                      verFiltro3 = true;
                                      liderNombre = '$liderSeleccionado';
                                    });
                                    resposable.add(const DropdownMenuEntry(
                                        value: 'TODOS', label: 'TODOS'));
                                    setState(() {
                                      _status3 = true;
                                    });
                                  }
                                },
                                width: 300,
                                hintText: "LIDER",
                                controller: textLider,
                                dropdownMenuEntries: lider,
                                textStyle:
                                    const TextStyle(color: Color(0xFF9A652F)),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF9A652F)),
                                  fillColor: Color(0xFFE6AB44),
                                  focusColor: Color(0xFFE6AB44),
                                  hoverColor: Color(0xFFE6AB44),
                                ),
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
                    (_status3)
                        ? Visibility(
                            visible: verFiltro3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 50, right: 50),
                              child: DropdownMenu(
                                onSelected: (responsableRed) async {
                                  if (responsableRed == 'TODOS') {
                                    setState(() {
                                      caso = 3;
                                      mostrarBotones = true;
                                    });
                                  } else {
                                    setState(() {
                                      responsableNombre = '$responsableRed';
                                      caso = 4;
                                      mostrarBotones = true;
                                    });
                                  }
                                },
                                width: 300,
                                hintText: "RESPOSABLE DE RED",
                                controller: textReponsable,
                                dropdownMenuEntries: resposable,
                                textStyle:
                                    const TextStyle(color: Color(0xFF9A652F)),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF9A652F)),
                                  fillColor: Color(0xFFE6AB44),
                                  focusColor: Color(0xFFE6AB44),
                                  hoverColor: Color(0xFFE6AB44),
                                ),
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
                    mostrarBotones
                        ? (cargando)
                            ? Column(
                                children: [
                                  CustomElevatedButton(
                                    text: 'EXCEL',
                                    onPressed: seleccionCaso,
                                  ),
                                  CustomElevatedButton(
                                    text: 'PDF',
                                    onPressed: seleccionCaso,
                                  ),
                                  CustomElevatedButton(
                                    text: 'AMBOS',
                                    onPressed: () {},
                                  ),
                                ],
                              )
                            : const Padding(
                                padding: EdgeInsets.only(
                                    top: 20, bottom: 20, left: 50, right: 50),
                                child: CircularProgressIndicator(
                                  color: Color(0xFFE6AB44),
                                ),
                              )
                        : const Padding(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 50, right: 50),
                            child: Text('Completa los filtros'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
