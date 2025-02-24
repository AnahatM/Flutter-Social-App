import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_button.dart';
import 'package:minimalist_social_media/components/my_text_field.dart';
import 'package:minimalist_social_media/utilities.dart';

class LoginPage extends StatefulWidget {
  // Register Page Link OnTap Function
  final void Function()? onRegisterTap;

  const LoginPage({super.key, required this.onRegisterTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text Field Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login Button OnTap Function
  void login() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Check if all fields are filled
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Hide Loading Indicator
      Navigator.pop(context);
      // Show Error Dialog
      displayPopupMessage(
        context,
        "Incomplete Fields",
        "Please enter all required fields to register.",
      );
      return;
    }

    // Try Sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Hide loading circle
      if (mounted) Navigator.pop(context);

      // Navigate to Home Page
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home_page');
      }
    }
    // Display any errors
    on FirebaseAuthException catch (e) {
      if (mounted) {
        // Hide loading circle
        Navigator.pop(context);
        // Show error dialog
        displayPopupMessage(
          context,
          "Login Error",
          e.message ?? "An Error Occured.",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 25),

              // App Title
              Text("S O C I A L", style: TextStyle(fontSize: 20)),

              const SizedBox(height: 50),

              // Email Textfield
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),

              const SizedBox(height: 10),

              // Password Textfield
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),

              const SizedBox(height: 10),

              // Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Login Button
              MyButton(text: "Login", onTap: login),

              const SizedBox(height: 20),

              // Register Page Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onRegisterTap,
                    child: Text(
                      "Register Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
