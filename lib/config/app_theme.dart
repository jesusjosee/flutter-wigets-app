import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class Apptheme {
  final int selectColor;

  Apptheme({this.selectColor = 0})
      : assert(selectColor >= 0, 'selectColor must be greater than 0'),
        assert(selectColor < colorList.length, 'selectColor must be les than ${colorList.length - 1}');

  // Configurar tema global
  ThemeData getTheme() => ThemeData(
    useMaterial3: true, 
    colorSchemeSeed: colorList[selectColor], // colorSchemeSeed genera los colores
    // configurar los appBars
    appBarTheme: const AppBarTheme(
      centerTitle: true , // centrar titulo de appbars
    )
  );

  // Configurar botones

  
}
