import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditUserScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const EditUserScreen({super.key, required this.userData});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final TextEditingController textPasswordController = TextEditingController();

  final focusNode1 = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool visible = false;
  final focusNode2 = FocusNode();

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
                  "EDITAR\n USUARIO",
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
                    TarjetaDeInformacion(
                      userData: widget.userData,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 50, right: 50, top: 50),
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
                    CustomElevatedButton(
                        text: "GUARDAR CAMBIO",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
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
                            final resultado =
                                await ApiRequests.updateEncuestadorPassword({
                              "id": widget.userData['id_usuario'],
                              "pass": textPasswordController.text.trim()
                            });
                            if (resultado) {
                              if (context.mounted) {
                                context.pop();
                                textPasswordController.text = "";
                              }
                            } else {
                              if (context.mounted) {
                                context.pop();
                              }
                            }
                          }
                        }),
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
