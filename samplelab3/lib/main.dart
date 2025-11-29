import 'package:flutter/material.dart';
import 'screens/movie_list_screen.dart';

// void main() is the entry point of every Dart/Flutter app - it runs first
void main() {
  // runApp() starts the Flutter application and takes a widget as the root of the app
  runApp(const MyApp());
}

// StatelessWidget is a widget that never changes after it's built
// Use StatelessWidget when the UI doesn't need to update based on user interaction
class MyApp extends StatelessWidget {
  // const constructor allows this widget to be created at compile-time for better performance
  // super.key passes the key parameter to the parent StatelessWidget class
  const MyApp({super.key});

  // @override means we're replacing the build method from the parent class (StatelessWidget)
  // build() is called by Flutter to create the widget's UI
  // BuildContext gives information about the widget's location in the widget tree
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the root widget for apps using Material Design
    // It provides navigation, theming, and other app-wide features
    return MaterialApp(
      // title appears in the device's task switcher/app switcher
      title: 'Movie Rating App',
      // debugShowCheckedModeBanner: false removes the "DEBUG" banner in the top-right corner
      debugShowCheckedModeBanner: false,
      // ThemeData defines the app's visual theme (colors, fonts, etc.)
      // home is the first screen/widget displayed when the app starts
      home: const MovieListScreen(),
    );
  }
}
