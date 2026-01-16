import 'package:flutter/material.dart';
import 'artdataservice.dart';

// =============================================================================
// NewArt - Add New Art Form Screen (StatefulWidget)
// =============================================================================
// This screen contains a form to add a new art piece to the gallery.
//
// WHY StatefulWidget?
// - TextEditingController requires a StatefulWidget to properly manage lifecycle
// - The form has mutable state (text input values)
// =============================================================================

class NewArt extends StatefulWidget {
  const NewArt({super.key});

  @override
  State<NewArt> createState() => _NewArtState();
}

class _NewArtState extends State<NewArt> {
  // TextEditingController - Used to read and control text input
  // ------------------------------------------------------------
  // Each TextField needs its own controller to:
  // 1. Read the current text value (controller.text)
  // 2. Set text programmatically if needed
  // 3. Clear the field
  // 4. Listen for changes
  //
  // These are NOT static because:
  // - Each time we visit this screen, we want fresh/empty controllers
  // - Instance variables are recreated when the widget is created
  final TextEditingController controllerId = TextEditingController();
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerArtist = TextEditingController();
  final TextEditingController controllerImage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Add a new Art Piece',
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField for Art ID input
            // 'controller' connects this TextField to our controllerId
            TextField(
              controller: controllerId,
              decoration: const InputDecoration(
                labelText: 'ArtID',                    // Hint text above the field
                border: OutlineInputBorder(),          // Adds a border around the field
              ),
            ),

            const SizedBox(height: 16), // Spacing between fields

            // TextField for Title input
            TextField(
              controller: controllerTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // TextField for Artist input
            TextField(
              controller: controllerArtist,
              decoration: const InputDecoration(
                labelText: 'Artist',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // TextField for Image filename input
            TextField(
              controller: controllerImage,
              decoration: const InputDecoration(
                labelText: 'Image Filename',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // FilledButton - A Material 3 button with filled background
            FilledButton(
              onPressed: () {
                // Add the new art using our STATIC data service method
                // controller.text retrieves the current text from each TextField
                ArtDataService.addArt(
                  controllerId.text,      // Get text from ID field
                  controllerTitle.text,   // Get text from Title field
                  controllerArtist.text,  // Get text from Artist field
                  controllerImage.text,   // Get text from Image field
                );

                // Navigate back to the previous screen (ArtSummary)
                // pop() removes this screen from the navigation stack
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
