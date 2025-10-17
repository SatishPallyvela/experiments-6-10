// Importing Flutter's Material Design package
// This gives access to all the UI widgets like Text, Center, Scaffold, etc.
import 'package:flutter/material.dart';

// A stateless widget — means this page does NOT change dynamically
// It is mainly used for displaying simple UI or debug information.
class DebugPage extends StatelessWidget {
  const DebugPage({
    super.key,
  }); // Constructor with an optional key (used internally by Flutter)

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------
    // 🪲 debugPrint() — a Flutter function used to print messages
    // in the Debug Console (like print(), but safer for long text).
    //
    // Here, it prints a message each time this widget is built,
    // showing the exact date and time when the widget was rebuilt.
    //
    // This is useful for testing rebuild behavior, hot reloads,
    // or tracking widget lifecycle during development.
    // ----------------------------------------------------------
    debugPrint('DebugPage built at: ${DateTime.now()}');

    // ----------------------------------------------------------
    // Center widget simply centers its child both vertically
    // and horizontally on the screen.
    // ----------------------------------------------------------
    return const Center(
      // Text widget displays a short message to the user
      // indicating where to look (Debug Console in IDE)
      child: Text('Open the Debug Console to view debugPrint output'),
    );
  }
}
