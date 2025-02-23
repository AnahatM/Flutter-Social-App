import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Logout Function
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Column of Widgets aligned to top of Drawer
          Column(
            children: [
              // Drawer Header
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(height: 25),

              // Home Tile
              MyDrawerTile(
                title: "H O M E",
                icon: Icons.home,
                onTap: () {
                  // Already at homepage, hide drawer
                  Navigator.pop(context);
                },
              ),

              // Profile Tile
              MyDrawerTile(
                title: "P R O F I L E",
                icon: Icons.person,
                onTap: () {
                  // Hide drawer
                  Navigator.pop(context);
                  // Navigate to Profile Page
                  Navigator.pushNamed(context, '/profile_page');
                },
              ),

              // Users Tile
              MyDrawerTile(
                title: "U S E R S",
                icon: Icons.people,
                onTap: () {
                  // Hide drawer
                  Navigator.pop(context);
                  // Navigate to Users Page
                  Navigator.pushNamed(context, '/users_page');
                },
              ),
            ],
          ),
          // Logout Tile, aligned to bottom of Drawer
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyDrawerTile(
              title: "L O G O U T",
              icon: Icons.logout,
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
