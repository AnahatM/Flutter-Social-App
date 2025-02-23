import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_button.dart';
import 'package:minimalist_social_media/components/my_text_field.dart';

class LoginPage extends StatelessWidget {
  // Register Page Link OnTap Function
  final void Function()? onRegisterTap;

  LoginPage({super.key, required this.onRegisterTap});

  // Text Field Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login Button OnTap Function
  void login() {}

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
              Text("S T A L K E R", style: TextStyle(fontSize: 20)),

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
                    onTap: onRegisterTap,
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
