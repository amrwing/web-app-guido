import 'package:flutter/material.dart';

class CustomAppBarOnlyMenu extends AppBar {
  CustomAppBarOnlyMenu({
    super.key,
  });

  @override
  State<CustomAppBarOnlyMenu> createState() => _CustomAppBarOnlyMenuState();
}

class _CustomAppBarOnlyMenuState extends State<CustomAppBarOnlyMenu> {
  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
