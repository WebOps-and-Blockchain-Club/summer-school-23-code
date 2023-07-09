import 'package:flutter/material.dart';

class Themes {
  static final ThemeData theme = ThemeData(
      fontFamily: "Itim",
      primaryColor: const Color.fromRGBO(43, 52, 103, 1),
      useMaterial3: true,

      //text
      textTheme: const TextTheme(
              bodySmall: TextStyle(),
              bodyMedium: TextStyle(),
              bodyLarge: TextStyle())
          .apply(
        bodyColor: const Color.fromRGBO(43, 52, 103, 1),
        displayColor: const Color.fromRGBO(43, 52, 103, 1),
      ),

      //text input
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(43, 52, 103, 1)),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          labelStyle: TextStyle(fontSize: 20)));
}
