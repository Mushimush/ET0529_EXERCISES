// Import Flutter's material design library for UI components
import 'package:flutter/material.dart';

// ArtPage is a StatefulWidget because it needs to manage changing state
// (in this case, the background color that changes when the button is pressed)
// StatefulWidget is used when the UI needs to change dynamically during runtime
class ArtPage extends StatefulWidget {
  // Constructor with a named 'key' parameter
  // The 'key' helps Flutter identify and track this widget in the widget tree
  const ArtPage({super.key});

  // createState() is required for StatefulWidget
  // It creates the mutable state object that will be associated with this widget
  @override
  State<ArtPage> createState() => _ArtPageState();
}

// _ArtPageState is the State class that holds the mutable data for ArtPage
// The underscore (_) makes this class private to this file
// This is where we define what data can change and how the UI responds to those changes
class _ArtPageState extends State<ArtPage> {
  // State variable to track the current background color
  // Initially set to black, will toggle between black and pink
  Color backgroundColor = Colors.black;

  // State variable to track the text displayed on the button
  // This text will change based on what action the button will perform next
  String buttonText = 'set background to pink';

  // This function toggles the background color between black and pink
  // It's called whenever the button is pressed
  void toggleBackground() {
    // setState() tells Flutter that the state has changed and the UI needs to rebuild
    // Without setState(), changes to variables won't update the UI
    setState(() {
      // Check the current background color and switch it
      if (backgroundColor == Colors.black) {
        // If currently black, change to pink
        backgroundColor = Colors.pink;
        buttonText = 'set background to black';
      } else {
        // If currently pink (or any other color), change back to black
        backgroundColor = Colors.black;
        buttonText = 'set background to pink';
      }
    });
  }

  // build() method is called whenever setState() is triggered
  // It describes what the UI should look like based on the current state
  // BuildContext provides information about where this widget is in the widget tree
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual structure for Material Design apps
    // It gives us an AppBar, body, and other common layout elements
    return Scaffold(
      // AppBar is the top bar of the screen that typically contains the title
      appBar: AppBar(
        // Custom beige/yellow color for the AppBar using ARGB values
        // ARGB: Alpha (opacity), Red, Green, Blue - each value from 0-255
        backgroundColor: const Color.fromARGB(255, 251, 236, 152),
        title: const Text('Art page'),
      ),

      // body contains the main content of the screen
      body: Container(
        // padding adds space inside the container on all sides (15 pixels)
        padding: const EdgeInsets.all(15),

        // The background color is controlled by our state variable
        // This will change when the button is pressed, triggering a rebuild
        color: backgroundColor,

        // Center widget centers its child horizontally and vertically
        child: Center(
          // SizedBox constrains the width of our content
          // This prevents the content from stretching too wide on larger screens
          child: SizedBox(
            width: 350,

            // Column arranges its children vertically in a list
            child: Column(
              // CrossAxisAlignment.start aligns children to the left (start)
              crossAxisAlignment: CrossAxisAlignment.start,

              // children is a list of widgets that will be displayed vertically
              children: [
                // ConstrainedBox limits the maximum height of the image
                // This prevents the image from taking up too much vertical space
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 400),

                  // Image.asset loads an image from the project's assets folder
                  child: Image.asset(
                    'assets/images/parasol.png', // Path to the image file
                    width: double.infinity, // Stretch to fill available width
                    fit: BoxFit.contain, // Scale image to fit without cropping
                  ),
                ),

                // SizedBox creates vertical spacing between widgets
                const SizedBox(height: 10),

                // Container for the artwork title and year with beige background
                Container(
                  width: double.infinity, // Stretch to fill available width
                  color: const Color.fromARGB(255, 251, 246, 201), // Light beige color
                  padding: const EdgeInsets.all(10), // Inner spacing

                  // Nested Column for title and year text
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Artwork title
                      Text(
                        'Woman with a Parasol',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5), // Small spacing between title and year
                      // Year and medium information
                      Text('1875 (oil on canvas)'),
                    ],
                  ),
                ),

                const SizedBox(height: 10), // Spacing after the beige box

                // Artist name text (displayed in white on the dark background)
                const Text(
                  'Claude Monet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text to contrast with dark background
                  ),
                ),

                const SizedBox(height: 5), // Small spacing

                // Location text (where the artwork is currently housed)
                const Text(
                  '(National Gallery of Art, Washington, D.C)',
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20), // Extra spacing before the button

                // ElevatedButton is a Material Design raised button
                ElevatedButton(
                  // onPressed defines what happens when the button is tapped
                  // Here we call our toggleBackground function
                  onPressed: toggleBackground,

                  // The button's label text comes from our state variable
                  // This text will change to indicate the next action
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
