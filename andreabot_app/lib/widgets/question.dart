import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Question extends StatelessWidget {
  final String text;
  final TextEditingController eC;
  final int tipo;
  final bool estado;

  Question({
    required this.text,
    required this.eC,
    required this.tipo,
    required this.estado,
    super.key,
  });
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    if (tipo == 1) {
      //normal - texto y numeros
      return Padding(
        padding:
            const EdgeInsets.only(left: 24, top: 10, right: 24, bottom: 10),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: estado
                  ? const BorderSide(width: 1, color: Colors.black26)
                  : const BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                child: SizedBox(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 40),
                child: TextField(
                  onEditingComplete: () {
                    focusNode.focusInDirection(TraversalDirection.down);
                  },
                  focusNode: focusNode,
                  onTapOutside: (event) => focusNode.unfocus(),
                  controller: eC,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 17.0),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9A652F))),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF9A652F),
                    ),
                    fillColor: Color(0xFFE6AB44),
                    focusColor: Color(0xFFE6AB44),
                    hoverColor: Color(0xFFE6AB44),
                    hintText: "Tu respuesta",
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (tipo == 2) {
      //solo fechas
      return Padding(
        padding:
            const EdgeInsets.only(left: 24, top: 10, right: 24, bottom: 10),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: estado
                  ? const BorderSide(width: 1, color: Colors.black26)
                  : const BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                child: SizedBox(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 40),
                child: MyDatePicker(
                  eC: eC,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      //solo numeros
      return Padding(
        padding:
            const EdgeInsets.only(left: 24, top: 10, right: 24, bottom: 10),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: estado
                  ? const BorderSide(width: 1, color: Colors.black26)
                  : const BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                child: SizedBox(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 40),
                child: TextField(
                  onEditingComplete: () {
                    focusNode.focusInDirection(TraversalDirection.down);
                  },
                  focusNode: focusNode,
                  onTapOutside: (event) => focusNode.unfocus(),
                  controller: eC,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')), // Solo permite números
                    LengthLimitingTextInputFormatter(
                        10), // Limita a 9 caracteres
                  ],
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 17.0),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9A652F))),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF9A652F),
                    ),
                    fillColor: Color(0xFFE6AB44),
                    focusColor: Color(0xFFE6AB44),
                    hoverColor: Color(0xFFE6AB44),
                    hintText: "Tu respuesta",
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class MyDatePicker extends StatefulWidget {
  final TextEditingController eC;

  const MyDatePicker({super.key, required this.eC});
  @override
  // ignore: library_private_types_in_public_api
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.eC.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    widget.eC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.eC,
      readOnly: true,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9A652F))),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Color(0xFF9A652F),
        ),
        fillColor: const Color(0xFFE6AB44),
        focusColor: const Color(0xFFE6AB44),
        hoverColor: const Color(0xFFE6AB44),
        hintText: 'Fecha',
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
    );
  }
}
