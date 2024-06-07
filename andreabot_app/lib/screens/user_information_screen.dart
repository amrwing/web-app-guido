import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserInformationScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const UserInformationScreen({super.key, required this.userData});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
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
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Text(
                  "DISTRITO ${widget.userData['distrito']}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xFFBC7027),
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  TarjetaDeInformacion(userData: widget.userData),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
