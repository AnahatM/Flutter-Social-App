import 'package:flutter/material.dart';
import 'package:minimalist_social_media/auth/login_or_register.dart';
import 'package:minimalist_social_media/themes/dark_mode.dart';
import 'package:minimalist_social_media/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegister(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
