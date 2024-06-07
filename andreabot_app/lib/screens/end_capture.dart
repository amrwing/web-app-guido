import 'package:andreabot_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EndCapture extends StatefulWidget {
  const EndCapture({super.key});

  @override
  State<EndCapture> createState() => _EndCaptureState();
}

class _EndCaptureState extends State<EndCapture> {
  void nuevaCaptura() {
    setState(() {
      context.pop();
      context.pop();
      context.push('/responsable_de_red/cuestionario_captura');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawerEncuestador(),
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Text(
                    "CAPTURA FINALIZADA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFFBC7027),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            CustomElevatedButton(text: 'NUEVA CAPTURA', onPressed: nuevaCaptura)
          ],
        ),
      ),
    );
  }
}
