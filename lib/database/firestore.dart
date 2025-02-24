/*

This database stores posts that users have published in the app.
It is stored in a collection called 'Posts' in Firestore.

Each post contains the following fields:
- 'PostMessage': The text content of the post
- 'UserEmail': The email of the post author
- 'TimeStamp': The time the post was created

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // Current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // Get collection of posts from firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection(
    'Posts',
  );

  // Post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // Read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    return posts.orderBy('TimeStamp', descending: true).snapshots();
  }
}
