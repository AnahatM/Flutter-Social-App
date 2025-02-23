import 'package:flutter/material.dart';
import 'package:minimalist_social_media/pages/login_page.dart';
import 'package:minimalist_social_media/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between Login and Register Page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LoginPage(onRegisterTap: togglePages)
        : RegisterPage(onLoginTap: togglePages);
  }
}
