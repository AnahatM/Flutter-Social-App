import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_media/auth/login_or_register.dart';
import 'package:minimalist_social_media/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is Logged in
          if (snapshot.hasData) {
            return const HomePage();
          }
          // User is Logged out
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
