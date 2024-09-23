import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
//import 'package:android_intent_plus/android_intent.dart';
//import 'package:android_intent_plus/flag.dart';
import 'puzzle_screen.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    bool isInstagramActive =
        await BackgroundService.isAppActive('com.instagram.android');
    bool isYouTubeActive =
        await BackgroundService.isAppActive('com.google.android.youtube');

    if (isInstagramActive || isYouTubeActive) {
      // Trigger the puzzle pop-up
      BackgroundService.showPuzzlePopup();
    }

    return Future.value(true);
  });
}

class BackgroundService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void registerTask() {
    Workmanager().registerPeriodicTask(
      "1",
      "checkAppsTask",
      frequency: const Duration(minutes: 15),
    );
  }

  static const platform = MethodChannel('com.example.befocused/app_usage');

  static Future<bool> isAppActive(String packageName) async {
    try {
      final bool result =
          await platform.invokeMethod('isAppActive', packageName);
      return result;
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to get app status: '${e.message}'.");
      return false;
    }
  }

  static void showPuzzlePopup() {
    final context = GlobalKey<NavigatorState>().currentContext;
    if (context != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PuzzleScreen()),
      );
    }
  }
}
