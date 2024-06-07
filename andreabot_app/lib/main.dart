import 'package:andreabot_app/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Color(0xFFE6AB44))),
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFFE6AB44),
              selectionColor: Color(0xFFE6AB44),
              selectionHandleColor: Color(0xFFE6AB44))),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
