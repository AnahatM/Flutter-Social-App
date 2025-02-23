import 'package:flutter/material.dart';

// Method to display a message to the user
displayPopupMessage(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(title),
          content: Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
  );
}
