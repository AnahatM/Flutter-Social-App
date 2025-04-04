import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_button.dart';
import 'package:minimalist_social_media/components/my_text_field.dart';
import 'package:minimalist_social_media/utilities.dart';

class RegisterPage extends StatefulWidget {
  // Login Page Link OnTap Function
  final void Function()? onLoginTap;

  const RegisterPage({super.key, required this.onLoginTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text Field Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Register Button OnTap Function
  void registerUser() async {
    // Show Loading Indicator
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Check if all fields are filled
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
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

    // Check if password and confirm password match
    if (passwordController.text != confirmPasswordController.text) {
      // Hide Loading Indicator
      Navigator.pop(context);
      // Show Error Dialog
      displayPopupMessage(
        context,
        "Password Mismatch",
        "Password and Confirm Password do not match.",
      );
      return;
    }

    // Register User
    try {
      // Try Creating User with Email and Password
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      // Create a User document in Firestore
      createUserDocument(userCredential);

      // Pop Loading Indicator
      if (mounted) {
        Navigator.pop(context);
      }

      // Clear Text Fields
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Navigate to Home Page
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home_page');
      }
    }
    // Display any errors
    on FirebaseAuthException catch (e) {
      if (mounted) {
        // Pop Loading Indicator
        Navigator.pop(context);
        // Show Error Dialog
        displayPopupMessage(
          context,
          "Error",
          e.message ?? "An error occurred.",
        );
      }
    }
  }

  // Create User Document in Firestore Function
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential == null || userCredential.user == null) return;
    // Create User Document
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userCredential.user!.email)
        .set({
          'email': userCredential.user!.email,
          'username': usernameController.text,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
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

                // Username Textfield
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
                MyButton(text: "Register", onTap: registerUser),

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
                      onTap: widget.onLoginTap,
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
      ),
    );
  }
}
