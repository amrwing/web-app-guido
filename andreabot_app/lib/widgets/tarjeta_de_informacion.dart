import 'package:flutter/material.dart';

class TarjetaDeInformacion extends StatelessWidget {
  const TarjetaDeInformacion({
    super.key,
    required this.userData,
  });

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: const Color(0xFFFce9cd),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30.0, right: 30, top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Responsable de red ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "- ${userData['id_usuario']}",
                    maxLines: 2,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Encuestas ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("- ${userData['total_capturas']}")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Ultima hora ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text((userData['ultima_captura'] is String)
                      ? "${userData['ultima_captura'].split("T")[1].split("Z")[0].split(".")[0]} ${(DateTime.now().difference(DateTime.parse(userData['ultima_captura'])).inDays > 1) ? "(Hace ${DateTime.now().difference(DateTime.parse(userData['ultima_captura'])).inDays} días)" : ((DateTime.now().difference(DateTime.parse(userData['ultima_captura'])).inHours < 24)) ? "Hoy" : "Ayer"}  "
                      : "No disponible")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
