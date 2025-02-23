import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_media/auth/auth.dart';
import 'package:minimalist_social_media/firebase_options.dart';
import 'package:minimalist_social_media/themes/dark_mode.dart';
import 'package:minimalist_social_media/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
