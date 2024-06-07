import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/models/usuario.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateUserScreenAdd extends StatefulWidget {
  const CreateUserScreenAdd({super.key});

  @override
  State<CreateUserScreenAdd> createState() => _CreateUserScreenAddState();
}

class _CreateUserScreenAddState extends State<CreateUserScreenAdd> {
  final TextEditingController textUserController = TextEditingController();

  final TextEditingController textPasswordController = TextEditingController();
  final TextEditingController textRoleController = TextEditingController();

  final focusNode1 = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final focusNode2 = FocusNode();
  bool _estadoDropdown = false;
  bool visible = false;
  List<DropdownMenuEntry<dynamic>> roles = [
    const DropdownMenuEntry(
        value: "responsable_de_red", label: "RESPONSABLE DE RED"),
    const DropdownMenuEntry(value: "supervisor", label: "SUPERVISOR"),
  ];
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
                  "NUEVO \nUSUARIO",
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
                          hintText: "NOMBRE",
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Espacio requerido";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF9A652F))),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF9A652F),
                            ),
                            fillColor: const Color(0xFFE6AB44),
                            focusColor: const Color(0xFFE6AB44),
                            hoverColor: const Color(0xFFE6AB44),
                            hintText: "CONTRASEÑA",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                },
                                icon: (visible)
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off))),
                        onTapOutside: (e) => focusNode2.unfocus(),
                        focusNode: focusNode2,
                        obscureText: !visible,
                        controller: textPasswordController,
                      ),
                    ),
                    DropdownMenu(
                      onSelected: (value) {
                        setState(() {
                          _estadoDropdown = false;
                        });
                      },
                      errorText: (_estadoDropdown) ? "Debes seleccionar" : null,
                      width: 300,
                      hintText: "SELECCIONAR",
                      controller: textRoleController,
                      dropdownMenuEntries: roles,
                      textStyle: const TextStyle(color: Color(0xFF9A652F)),
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF9A652F),
                        ),
                        fillColor: Color(0xFFE6AB44),
                        focusColor: Color(0xFFE6AB44),
                        hoverColor: Color(0xFFE6AB44),
                      ),
                    ),
                    CustomElevatedButton(
                      text: "CREAR USUARIO",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (textRoleController.text.isNotEmpty) {
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

                            //CREAMOS NUEVO USUARIO CON LOS DATOS INGRESADOS
                            Usuario nuevoUsuario = Usuario(
                              usuario: textUserController.text.trim(),
                              role: (textRoleController.text ==
                                      "RESPONSABLE DE RED")
                                  ? "encuestador"
                                  : textRoleController.text
                                      .toLowerCase()
                                      .trim(),
                              password: textPasswordController.text.trim(),
                              token: usuarioActivo!.token,
                            );
                            //COMENZAR CON LA PETICIÓN A LA API PARA ESCRIBIR EL USUARIO
                            final resultado =
                                await ApiRequests.createUser(nuevoUsuario);
                            if (resultado) {
                              if (context.mounted) {
                                context.pop();
                                textUserController.text = "";
                                textPasswordController.text = "";
                                textRoleController.text = "";
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
