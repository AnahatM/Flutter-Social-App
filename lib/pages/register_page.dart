import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_button.dart';
import 'package:minimalist_social_media/components/my_text_field.dart';

class RegisterPage extends StatelessWidget {
  // Login Page Link OnTap Function
  final void Function()? onLoginTap;

  RegisterPage({super.key, required this.onLoginTap});

  // Text Field Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Register Button OnTap Function
  void register() {}

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
                hintText: 'Username',
                obscureText: false,
                controller: usernameController,
              ),

              const SizedBox(height: 10),

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

              // Confirm Password Textfield
              MyTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmPasswordController,
              ),

              const SizedBox(height: 25),

              // Register Button
              MyButton(text: "Register", onTap: register),

              const SizedBox(height: 20),

              // Login Page Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: onLoginTap,
                    child: Text(
                      "Login Here",
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
