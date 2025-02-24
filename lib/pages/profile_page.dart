import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_back_button.dart';
import 'package:minimalist_social_media/components/my_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current Logged-in User Profile Data
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: fetchUserDetails(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Error Handling
          else if (snapshot.hasError) {
            return Text("Error fetching user data: ${snapshot.error}");
          }

          // Check Data Received
          if (!snapshot.hasData) {
            return const Text("No data found.");
          }

          // Extract Data
          Map<String, dynamic>? userData = snapshot.data!.data();

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Column for Top-Aligned Profile UI
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Back Button
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 25.0),
                      child: Row(children: [MyBackButton()]),
                    ),

                    const SizedBox(height: 25),

                    // Profile Picture
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Username
                    Text(
                      userData!['username'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Email
                    Text(
                      userData['email'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),

                // Logout Button aligned to the bottom
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 50,
                  ),
                  child: MyButton(
                    text: "Logout",
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login_register_page',
                          (route) => false,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
