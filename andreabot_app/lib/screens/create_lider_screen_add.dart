import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class CreateLiderScreenAdd extends StatefulWidget {
  const CreateLiderScreenAdd({super.key});

  @override
  State<CreateLiderScreenAdd> createState() => _CreateLiderScreenAddState();
}

class _CreateLiderScreenAddState extends State<CreateLiderScreenAdd> {
  final TextEditingController textTelefonoController = TextEditingController();
  final TextEditingController textUserController = TextEditingController();
  final TextEditingController textOriginController = TextEditingController();

  bool _estadoDropdown = false;
  final focusNode1 = FocusNode();

  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuEntry<dynamic>> origenes = [];
  bool _status = false;
  @override
  void initState() {
    super.initState();
    //{"status":"200","message":"Origenes obtenidos","data":{"status":200,"output":[{"idorigen":"Fundacion Andrhani "},{"idorigen":"Rancho Perez"}]}}
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
          _status = true;
        });
      } else {
        context.pop();
        Fluttertoast.showToast(
            msg: "Servicio no disponible, intentelo más tarde");
      }
    });
  }

  bool visible = false;

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
                child: Text(
                  "NUEVO \nLIDER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFBC7027),
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    (_status)
                        ? DropdownMenu(
                            onSelected: (value) {
                              setState(() {
                                _estadoDropdown = false;
                              });
                            },
                            errorText:
                                (_estadoDropdown) ? "Debes seleccionar" : null,
                            width: 300,
                            hintText: "SELECCIONAR ORIGEN",
                            controller: textOriginController,
                            dropdownMenuEntries: origenes,
                            textStyle:
                                const TextStyle(color: Color(0xFF9A652F)),
                            inputDecorationTheme: const InputDecorationTheme(
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF9A652F),
                              ),
                              fillColor: Color(0xFFE6AB44),
                              focusColor: Color(0xFFE6AB44),
                              hoverColor: Color(0xFFE6AB44),
                            ),
                          )
                        : const CircularProgressIndicator(
                            color: Color(0xFFE6AB44),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 50, right: 50),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Espacio requerido";
                          }
                          return null;
                        },
                        focusNode: focusNode1,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF9A652F))),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF9A652F),
                          ),
                          fillColor: Color(0xFFE6AB44),
                          hintText: "LIDER",
                          focusColor: Color(0xFFE6AB44),
                          hoverColor: Color(0xFFE6AB44),
                        ),
                        onTapOutside: (e) => focusNode1.unfocus(),
                        controller: textUserController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 50, right: 50),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Espacio requerido";
                          } else if (value.length != 10) {
                            return "10 digitos solamente";
                          }
                          return null;
                        },
                        focusNode: focusNode3,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF9A652F))),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF9A652F),
                          ),
                          fillColor: Color(0xFFE6AB44),
                          hintText: "TELEFONO",
                          focusColor: Color(0xFFE6AB44),
                          hoverColor: Color(0xFFE6AB44),
                        ),
                        onTapOutside: (e) => focusNode3.unfocus(),
                        controller: textTelefonoController,
                      ),
                    ),
                    CustomElevatedButton(
                      text: "CREAR LIDER",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (textOriginController.text.isNotEmpty) {
                            setState(() {
                              _estadoDropdown = false;
                            });
                            showAdaptiveDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFE6AB44),
                                ),
                              ),
                            );
                            //COMENZAR CON LA PETICIÓN A LA API PARA ESCRIBIR EL USUARIO
                            final resultado = await ApiRequests.createLider(
                                textOriginController.text.trim(),
                                textUserController.text.trim(),
                                textTelefonoController.text.trim());
                            if (resultado) {
                              if (context.mounted) {
                                context.pop();
                                textOriginController.text = "";
                                textUserController.text = "";
                                textTelefonoController.text = "";
                              }
                            } else {
                              if (context.mounted) {
                                context.pop();
                              }
                            }
                          } else {
                            setState(() {
                              _estadoDropdown = true;
                            });
                          }
                        }
                      },
                    ),
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
