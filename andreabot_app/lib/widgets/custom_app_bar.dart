import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 200,
        //CAMBIAR EL ICON POR EL LOGO
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Image.asset(
            "assets/logos/movimiento_cristiano.jpg",
          ),
        ),
      ),
    );
  }
}
