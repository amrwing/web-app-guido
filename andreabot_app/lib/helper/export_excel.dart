import 'package:excel/excel.dart';
import 'package:excel/excel.dart' as xl;
//import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:andreabot_app/helper/save_file_mobile.dart';
import '../API/requests__api.dart';

Future<void> casoExcel1() async {
  CellStyle cellStyle = CellStyle(
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    fontSize: 11,
    leftBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    rightBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    topBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    bottomBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
  );
  CellStyle cellStyle2 = CellStyle(
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: ExcelColor.orange,
    fontSize: 12,
    leftBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    rightBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    topBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    bottomBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
  );
  List<String> letra = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M'
  ];
  List<String> indices = [
    'NOMBRE',
    'DOMICILIO',
    'NO. EXT',
    'NO. INT',
    'FECHA DE NACIM.',
    'TELEFONO',
    'CELULAR',
    'PERFIL FACEBOOK',
    'CLAVE ELECTOR',
    'DISTRITO / SECCION',
    'ORIGEN',
    'LIDER',
    'RESP'
  ];
  List<List<String>> informacion = [];

  //Leer toda la info y guardarla
  final respuesta = await ApiRequests.getAllEncuestas();

  if (respuesta is List) {
    for (var encuesta in respuesta) {
      String nombreE =
          '${encuesta['nombre']} ${encuesta['apellido_paterno']} ${encuesta['apellido_materno']}';
      String domE = encuesta['domicilio'];
      String noExE = encuesta['no_ext'];
      String noInE = encuesta['no_int'];
      String fechaNE = encuesta['fecha_nacimiento'];
      String telE = encuesta['telefono'];
      String celE = encuesta['celular'];
      String perfilF = encuesta['perfil_facebook'];
      String claveE = encuesta['clave_elector'];
      String seccionDisE = '${encuesta['distrito']} / ${encuesta['seccion']}';
      String origenE = encuesta['origen_idorigen'];
      String liderE = encuesta['idlider'];
      String responsE = encuesta['responsable_red_usuario_idusuario'];
      informacion.add([
        nombreE,
        domE,
        noExE,
        noInE,
        fechaNE,
        telE,
        celE,
        perfilF,
        claveE,
        seccionDisE,
        origenE,
        liderE,
        responsE
      ]);
    }
  }

  var excel = Excel.createExcel();

  Sheet sheetObject = excel['Sheet1'];

  int i = 0;
  for (String elemento in indices) {
    var cell = sheetObject.cell(CellIndex.indexByString('${letra[i]}1'));
    cell.value = null;
    cell.value = TextCellValue(elemento);
    cell.cellStyle = cellStyle2;
    i = i + 1;
  }

  i = 0;
  for (List<String> fila in informacion) {
    int x = 0;
    for (String elemento in fila) {
      var cell =
          sheetObject.cell(CellIndex.indexByString('${letra[x]}${i + 2}'));
      cell.value = null;
      cell.value = TextCellValue(elemento);
      cell.cellStyle = cellStyle;
      x = x + 1;
    }
    i = i + 1;
  }

  List<int>? fileBytes = excel.save();

  //Funciona
  if (fileBytes != null) {
    saveAndLaunchFile(true, fileBytes, 'resumen.xlsx');
  }
}

Future<void> casoExcel2(String origen) async {
  CellStyle cellStyle = CellStyle(
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    fontSize: 11,
    leftBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    rightBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    topBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    bottomBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
  );
  CellStyle cellStyle2 = CellStyle(
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: ExcelColor.orange,
    fontSize: 12,
    leftBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    rightBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    topBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    bottomBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
  );
  List<String> letra = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
  ];
  List<String> indices = [
    'NOMBRE',
    'DOMICILIO',
    'NO. EXT',
    'NO. INT',
    'FECHA DE NACIM.',
    'TELEFONO',
    'CELULAR',
    'PERFIL FACEBOOK',
    'CLAVE ELECTOR',
    'DISTRITO / SECCION',
    'LIDER',
    'RESP'
  ];
  List<List<String>> informacion = [];

  String origenMod = origen.replaceAll(' ', '%20');

  //Leer toda la info y guardarla
  final respuesta = await ApiRequests.getAllEncuestasOrigen(origenMod);

  if (respuesta is List) {
    for (var encuesta in respuesta) {
      String nombreE =
          '${encuesta['nombre']} ${encuesta['apellido_paterno']} ${encuesta['apellido_materno']}';
      String domE = encuesta['domicilio'];
      String noExE = encuesta['no_ext'];
      String noInE = encuesta['no_int'];
      String fechaNE = encuesta['fecha_nacimiento'];
      String telE = encuesta['telefono'];
      String celE = encuesta['celular'];
      String perfilF = encuesta['perfil_facebook'];
      String claveE = encuesta['clave_elector'];
      String seccionDisE = '${encuesta['distrito']} / ${encuesta['seccion']}';
      String liderE = encuesta['idlider'];
      String responsE = encuesta['responsable_red_usuario_idusuario'];
      informacion.add([
        nombreE,
        domE,
        noExE,
        noInE,
        fechaNE,
        telE,
        celE,
        perfilF,
        claveE,
        seccionDisE,
        liderE,
        responsE
      ]);
    }
  }

  var excel = Excel.createExcel();

  Sheet sheetObject = excel['Sheet1'];

  sheetObject.merge(
      CellIndex.indexByString('C1'), CellIndex.indexByString('L1'));
  sheetObject.merge(
      CellIndex.indexByString('A1'), CellIndex.indexByString('B1'));

  var cellOr = sheetObject.cell(CellIndex.indexByString('A1'));
  cellOr.value = null;
  cellOr.value = const TextCellValue('ORIGEN:');
  cellOr.cellStyle = cellStyle2;

  var cellO = sheetObject.cell(CellIndex.indexByString('C1'));
  cellO.value = null;
  cellO.value = TextCellValue(origen);
  cellO.cellStyle = cellStyle2;

  int i = 0;
  for (String elemento in indices) {
    var cell = sheetObject.cell(CellIndex.indexByString('${letra[i]}2'));
    cell.value = null;
    cell.value = TextCellValue(elemento);
    cell.cellStyle = cellStyle2;
    i = i + 1;
  }

  i = 0;
  for (List<String> fila in informacion) {
    int x = 0;
    for (String elemento in fila) {
      var cell =
          sheetObject.cell(CellIndex.indexByString('${letra[x]}${i + 3}'));
      cell.value = null;
      cell.value = TextCellValue(elemento);
      cell.cellStyle = cellStyle;
      x = x + 1;
    }
    i = i + 1;
  }

  List<int>? fileBytes = excel.save();

  //Funciona
  if (fileBytes != null) {
    saveAndLaunchFile(true, fileBytes, 'resumen.xlsx');
  }
}

Future<void> casoExcel3(String origen, String lider, String numero) async {
  //print(origen + lider + numero);
  CellStyle cellStyle = CellStyle(
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    fontSize: 11,
    leftBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    rightBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    topBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    bottomBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
  );
  CellStyle cellStyle2 = CellStyle(
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: ExcelColor.orange,
    fontSize: 12,
    leftBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    rightBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    topBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    bottomBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
  );
  CellStyle cellStyle3 = CellStyle(
    textWrapping: TextWrapping.WrapText,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: ExcelColor.yellow,
    fontSize: 12,
    leftBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    rightBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    topBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
    bottomBorder: xl.Border(
        borderStyle: xl.BorderStyle.Thin, borderColorHex: xl.ExcelColor.black),
  );
  List<String> letra = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
  ];
  List<String> indices = [
    'NOMBRE',
    'DOMICILIO',
    'NO. EXT',
    'NO. INT',
    'FECHA DE NACIM.',
    'TELEFONO',
    'CELULAR',
    'PERFIL FACEBOOK',
    'CLAVE ELECTOR',
    'DISTRITO / SECCION',
    'RESP'
  ];
  List<List<String>> informacion = [];

  String origenMod = origen.replaceAll(' ', '%20');
  String liderMod = lider.toLowerCase();
  liderMod = liderMod.replaceAll(' ', '%20');

  //Leer toda la info y guardarla
  final respuesta =
      await ApiRequests.getAllEncuestasOrigenLider(origenMod, liderMod);

  if (respuesta is List) {
    for (var encuesta in respuesta) {
      String nombreE =
          '${encuesta['nombre']} ${encuesta['apellido_paterno']} ${encuesta['apellido_materno']}';
      String domE = encuesta['domicilio'];
      String noExE = encuesta['no_ext'];
      String noInE = encuesta['no_int'];
      String fechaNE = encuesta['fecha_nacimiento'];
      String telE = encuesta['telefono'];
      String celE = encuesta['celular'];
      String perfilF = encuesta['perfil_facebook'];
      String claveE = encuesta['clave_elector'];
      String seccionDisE = '${encuesta['distrito']} / ${encuesta['seccion']}';
      String responsE = encuesta['responsable_red_usuario_idusuario'];
      informacion.add([
        nombreE,
        domE,
        noExE,
        noInE,
        fechaNE,
        telE,
        celE,
        perfilF,
        claveE,
        seccionDisE,
        responsE
      ]);
    }
  }

  var excel = Excel.createExcel();

  Sheet sheetObject = excel['Sheet1'];

  sheetObject.merge(
      CellIndex.indexByString('C1'), CellIndex.indexByString('L1'));
  sheetObject.merge(
      CellIndex.indexByString('A1'), CellIndex.indexByString('B1'));
  sheetObject.merge(
      CellIndex.indexByString('B2'), CellIndex.indexByString('E2'));
  sheetObject.merge(
      CellIndex.indexByString('G2'), CellIndex.indexByString('K2'));

  var cellOr = sheetObject.cell(CellIndex.indexByString('A1'));
  cellOr.value = null;
  cellOr.value = const TextCellValue('ORIGEN:');
  cellOr.cellStyle = cellStyle2;

  var cellO = sheetObject.cell(CellIndex.indexByString('C1'));
  cellO.value = null;
  cellO.value = TextCellValue(origen);
  cellO.cellStyle = cellStyle2;

  var cellL = sheetObject.cell(CellIndex.indexByString('A2'));
  cellL.value = null;
  cellL.value = const TextCellValue('LIDER:');
  cellL.cellStyle = cellStyle3;

  var cellLN = sheetObject.cell(CellIndex.indexByString('B2'));
  cellLN.value = null;
  cellLN.value = TextCellValue(lider);
  cellLN.cellStyle = cellStyle3;

  var cellLC = sheetObject.cell(CellIndex.indexByString('F2'));
  cellLC.value = null;
  cellLC.value = const TextCellValue('CELULAR:');
  cellLC.cellStyle = cellStyle3;

  var cellLCel = sheetObject.cell(CellIndex.indexByString('G2'));
  cellLCel.value = null;
  cellLCel.value = TextCellValue(numero);
  cellLCel.cellStyle = cellStyle3;

  int i = 0;
  for (String elemento in indices) {
    var cell = sheetObject.cell(CellIndex.indexByString('${letra[i]}3'));
    cell.value = null;
    cell.value = TextCellValue(elemento);
    cell.cellStyle = cellStyle2;
    i = i + 1;
  }

  i = 0;
  for (List<String> fila in informacion) {
    int x = 0;
    for (String elemento in fila) {
      var cell =
          sheetObject.cell(CellIndex.indexByString('${letra[x]}${i + 4}'));
      cell.value = null;
      cell.value = TextCellValue(elemento);
      cell.cellStyle = cellStyle;
      x = x + 1;
    }
    i = i + 1;
  }

  List<int>? fileBytes = excel.save();

  //Funciona
  if (fileBytes != null) {
    saveAndLaunchFile(true, fileBytes, 'resumen.xlsx');
  }
}

Future<void> casoExcel4(
    String origen, String lider, String numero, String responsable) async {
  //print(origen + lider + numero + responsable);
}
