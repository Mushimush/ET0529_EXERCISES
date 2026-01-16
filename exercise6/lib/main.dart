import 'package:flutter/material.dart';
import 'artsummary.dart';
import 'newart.dart';
import 'artdetails.dart';
import 'updateart.dart';
import 'artdataservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// =============================================================================
// Main Entry Point
// =============================================================================
// This is where the Flutter app starts. The main() function is called first
// when the app launches.
// =============================================================================

// =============================================================================
// ASYNC / AWAIT - Key Concepts for Firebase
// =============================================================================
//
// WHY DO WE NEED ASYNC/AWAIT?
// ---------------------------
// Firebase operations communicate with external cloud servers.
// The processing time is NOT within our app's control (network latency,
// server processing, etc). These are called ASYNCHRONOUS operations.
//
// WHAT IS 'await'?
// ----------------
// The 'await' keyword tells the app to WAIT until the operation completes
// before moving to the next line. Without 'await', the app would continue
// running while Firebase is still processing - causing bugs!
//
// WHAT IS 'async'?
// ----------------
// The 'async' keyword is REQUIRED on any function that uses 'await'.
// They ALWAYS work together - you cannot use 'await' without 'async'.
//
// EXAMPLE:
// --------
//   Without await:                    With await:
//   App: "Save this data"             App: "Save this data"
//   App: "Next task!" (too early!)    App: *waiting...*
//   Firebase: "Still working..."      Firebase: "Done!"
//                                     App: "Next task!" (correct!)
//
// =============================================================================

void main() async {
  // 'async' is required here because we use 'await' below

  // Required for async operations before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // 'await' - Wait for Firebase to fully initialize before continuing
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 'await' - Wait for all art data to load from Firestore before starting app
  await ArtDataService.getAllArts();

  // Only runs AFTER both async operations above are complete
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
        '/': (context) => const ArtSummary(),           // Home screen - list of art
        '/newart': (context) => const NewArt(),         // Form to add new art
        '/artdetails': (context) => const ArtDetails(), // Art detail view
        '/updateart': (context) => const UpdateArt(),   // Form to update art
      },
    );
  }
}
