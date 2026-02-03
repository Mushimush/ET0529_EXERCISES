// Q5: Main.dart - sets home page and necessary routing
import 'package:flutter/material.dart';
import 'home.dart';
import 'updatepet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption Center',
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // NAMED ROUTES - all routes defined in one place
      initialRoute: '/', // First screen to show when app starts

      // Route table - maps route names to screen widgets
      routes: {
        '/': (context) => const Home(),           // Home screen - list of pets
        '/updatepet': (context) => const UpdatePet(), // Update pet screen
      },
    );
  }
}
