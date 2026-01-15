import 'package:flutter/material.dart';
import 'artsummary.dart';
import 'newart.dart';
import 'artdetails.dart';

// =============================================================================
// Main Entry Point
// =============================================================================
// This is where the Flutter app starts. The main() function is called first
// when the app launches.
// =============================================================================

void main() {
  // runApp() takes a Widget and makes it the root of the widget tree
  // const MyApp() - 'const' means this widget won't change (immutable)
  runApp(const MyApp());
}

// =============================================================================
// MyApp - Root Widget (StatelessWidget)
// =============================================================================
// StatelessWidget is used here because the app configuration doesn't change.
// It sets up the MaterialApp with theme and navigation routes.
// =============================================================================

class MyApp extends StatelessWidget {
  // Constructor with 'super.key' for widget identification (required by Flutter)
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title shown in task switcher
      title: 'Art Dialog',

      // Theme configuration - sets the color scheme for the entire app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),

      // NAMED ROUTES - Navigation setup
      // --------------------------------
      // Routes allow navigation between screens using string names
      // Benefits:
      // 1. Centralized navigation configuration
      // 2. Easy to navigate: Navigator.pushNamed(context, '/newart')
      // 3. Can pass arguments through routes

      initialRoute: '/', // The first screen to show when app starts

      // Route table - maps route names to screen widgets
      routes: {
        '/': (context) => const ArtSummary(),      // Home screen - list of art
        '/newart': (context) => const NewArt(),     // Form to add new art
        '/artdetails': (context) => const ArtDetails(), // Art detail view
      },
    );
  }
}
