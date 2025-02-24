import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 28, 28, 28),
    primary: const Color.fromARGB(255, 33, 33, 32),
    secondary: Colors.grey.shade600,
    inversePrimary: Colors.grey.shade700,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey.shade300,
    displayColor: Colors.white,
  ),
);
