import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_drawer.dart';
import 'package:minimalist_social_media/components/my_list_tile.dart';
import 'package:minimalist_social_media/components/my_post_button.dart';
import 'package:minimalist_social_media/components/my_text_field.dart';
import 'package:minimalist_social_media/database/firestore.dart';
import 'package:minimalist_social_media/utilities.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Access firestore database
  final FirestoreDatabase database = FirestoreDatabase();

  // Text controller
  final TextEditingController newPostController = TextEditingController();

  // Post a message function
  void postMessage(BuildContext context) {
    // Check if the textfield is empty
    if (newPostController.text.isEmpty) {
      displayPopupMessage(context, "Empty Post", "Your post cannot be empty.");
      return;
    }

    // Post the message
    database.addPost(newPostController.text);

    // Clear the textfield
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        centerTitle: true,
        title: const Text("D I S C O V E R"),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // Textfield box for user to type a post
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "Say something...",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                MyPostButton(onTap: () => postMessage(context)),
              ],
            ),
          ),

          // Wall of Posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // Show Loading Circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Get all posts
              final posts = snapshot.data!.docs;

              // Check for no data
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text("No posts yet."),
                  ),
                );
              }

              // Return as a list
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // Get Each Individual Post
                      final post = posts[index];

                      // Get Data from Each Post
                      String message = post['PostMessage'];
                      String email = post['UserEmail'];
                      String date =
                          post['TimeStamp'].toDate().toLocal().toString().split(
                            ' ',
                          )[0];

                      // Return as a list tile
                      return MyListTile(
                        title: message,
                        subtitle: ("$email - $date"),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
