import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController textUserController = TextEditingController();

  final TextEditingController textPasswordController = TextEditingController();

  final focusNode1 = FocusNode();

  final focusNode2 = FocusNode();

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawerAdmin(),
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Text(
                "CREAR\n USUARIO",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFBC7027),
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
            CustomElevatedButton(
              text: "NUEVO USUARIO",
              onPressed: () {
                context.push(
                    "/admin_home_screen/create_user_screen/create_user_screen_add");
              },
            ),
            CustomElevatedButton(
              text: "NUEVO ORIGEN",
              onPressed: () {
                context.push(
                    "/admin_home_screen/create_user_screen/create_origen_screen_add");
              },
            ),
            CustomElevatedButton(
              text: "NUEVO LIDER",
              onPressed: () {
                context.push(
                    "/admin_home_screen/create_user_screen/create_lider_screen_add");
              },
            ),
          ],
        ),
      ),
    );
  }
}
