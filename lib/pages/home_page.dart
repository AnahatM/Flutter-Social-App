import 'package:flutter/material.dart';
import 'package:minimalist_social_media/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        centerTitle: true,
        title: const Text("Home"),
      ),
      drawer: MyDrawer(),
    );
  }
}
