// Import Flutter's material design library
// This gives us access to Material Design widgets like Scaffold, AppBar, etc.
import 'package:flutter/material.dart';

// Import our custom ArtPage widget from art_page.dart
import 'art_page.dart';

// The main() function is the entry point of every Flutter application
// This is the first function that runs when the app starts
void main() {
  // runApp() is a Flutter function that takes a widget and makes it the root of the widget tree
  // It inflates the given widget and attaches it to the screen
  runApp(const MaterialApp(
    // MaterialApp is a wrapper widget that provides Material Design features
    // like navigation, theming, and other essential app-wide configurations

    // The 'home' property defines the default route (first screen) of the app
    // Here we're setting ArtPage as our home screen
    home: ArtPage(),

    // debugShowCheckedModeBanner controls whether to show the "DEBUG" banner
    // in the top-right corner during development. We set it to false for a cleaner look
    debugShowCheckedModeBanner: false,
  ));
}
