import 'package:flutter/material.dart';
import 'background_service.dart';
import 'puzzle_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundService.initialize();
  BackgroundService.registerTask();
  runApp(const beFocused());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ignore: camel_case_types
class beFocused extends StatelessWidget {
  const beFocused({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const MainScreen(),
      routes: {
        '/puzzle': (context) => const PuzzleScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('beFocused'),
      ),
      body: const Center(
        child: Text('App is running in the background.'),
      ),
    );
  }
}
