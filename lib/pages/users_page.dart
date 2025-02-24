import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_back_button.dart';
import 'package:minimalist_social_media/components/my_list_tile.dart';
import 'package:minimalist_social_media/utilities.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          // Error Handling
          if (snapshot.hasError) {
            displayPopupMessage(
              context,
              "Request Error",
              "Error fetching users: ${snapshot.error}",
            );
          }

          // Show Loading Indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check data
          if (snapshot.data == null) {
            return const Text("No data found.");
          }

          // Get All Users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25.0),
                child: Row(children: [MyBackButton()]),
              ),
              // List of Users
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 15.0,
                  ),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    // Get individual user data
                    final user = users[index];

                    // Return as List Tile
                    return MyListTile(
                      title: user['username'],
                      subtitle: user['email'],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
