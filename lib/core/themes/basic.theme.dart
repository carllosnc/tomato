import 'package:flutter/material.dart';

appTheme({required bool isLight}) => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.yellowAccent,
      fontFamily: 'SFProDisplay',
      scaffoldBackgroundColor: Colors.black,
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    );
