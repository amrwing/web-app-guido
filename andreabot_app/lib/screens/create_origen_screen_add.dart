import 'package:andreabot_app/API/requests__api.dart';
import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateOrigenScreenAdd extends StatefulWidget {
  const CreateOrigenScreenAdd({super.key});

  @override
  State<CreateOrigenScreenAdd> createState() => _CreateOrigenScreenAddState();
}

class _CreateOrigenScreenAddState extends State<CreateOrigenScreenAdd> {
  final TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final focusNode1 = FocusNode();

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
                  "NUEVO\n ORIGEN",
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
                        controller: textController,
                      ),
                    ),
                    CustomElevatedButton(
                      text: "CREAR ORIGEN",
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
                          final resultado = await ApiRequests.createOrigen(
                              textController.text.trim().toLowerCase());
                          if (resultado) {
                            if (context.mounted) {
                              context.pop();
                              textController.text = "";
                            }
                          } else {
                            if (context.mounted) {
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
