import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/global/global.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController textUserController = TextEditingController();

  final TextEditingController textPasswordController = TextEditingController();
  final focusNode1 = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final focusNode2 = FocusNode();

  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  "assets/logos/movimiento_cristiano.jpg",
                  width: 150,
                  height: 150,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: Text(
                  "BIENVENIDO",
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
                        cursorColor: const Color(0xFFE6AB44),
                        focusNode: focusNode1,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF9A652F))),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF9A652F),
                          ),
                          fillColor: Color(0xFFE6AB44),
                          hintText: "USUARIO",
                          focusColor: Color(0xFFE6AB44),
                          hoverColor: Color(0xFFE6AB44),
                        ),
                        onTapOutside: (e) => focusNode1.unfocus(),
                        controller: textUserController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Espacio vacío";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 50, right: 50),
                      child: TextFormField(
                        cursorColor: const Color(0xFFE6AB44),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Espacio vacío";
                          }
                          return null;
                        },
                        controller: textPasswordController,
                      ),
                    ),
                    CustomElevatedButton(
                      text: "ENTRAR",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //MOSTRAMOS CIRCULO DE CARGA
                          showAdaptiveDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFE6AB44),
                              ),
                            ),
                          );
                          _formKey.currentState!.save();
                          usuarioActivo = await ApiRequests.logIn(
                              textUserController.text.trim(),
                              textPasswordController.text.trim());
                          if (usuarioActivo != null) {
                            if (context.mounted) {
                              //BORRAR EL TEXTO DE LOS CAMPOS
                              textUserController.text = "";
                              textPasswordController.text = "";
                              //CERRAR EL CIRCULO DE CARGA
                              context.pop();

                              if (usuarioActivo!.role == "admin") {
                                context.push("/admin_home_screen");
                              }
                              if (usuarioActivo!.role == "supervisor") {
                                context.push("/distritos_screen");
                              }
                              if (usuarioActivo!.role == "encuestador") {
                                context.push("/responsable_de_red");
                              }
                            }
                          } else {
                            if (context.mounted) {
                              //CERRAR EL CIRCULO DE CARGA
                              context.pop();
                            }
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
