// Saved Screen
import 'package:flutter/material.dart';
import 'package:insta_clone2/consts/list.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Saved')),
      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: public['publicImages'].length,
        itemBuilder: (context, index) {
          var public4 = public['publicImages']![index];
          return Image.asset(
            //'Saved ${index + 1}',
            public4,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
