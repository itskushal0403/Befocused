import 'package:flutter/material.dart';

class PuzzleScreen extends StatelessWidget {
  const PuzzleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solve this Puzzle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'What is (998-553)*2?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
              onSubmitted: (value) {
                if (value == '890') {
                  Navigator.pop(context);
                } else {
                  // Show error message
                }
              },
              decoration: const InputDecoration(
                hintText: 'Enter your answer',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
