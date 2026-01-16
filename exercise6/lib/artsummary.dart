import 'package:flutter/material.dart';
import 'artdataservice.dart';

// =============================================================================
// ArtSummary - Home Screen (StatefulWidget)
// =============================================================================
// This is the main screen showing a list of all art pieces.
//
// WHY StatefulWidget?
// - The list can change (add/delete items)
// - We need setState() to refresh the UI when data changes
// - After returning from another screen, we call setState() to rebuild
// =============================================================================

class ArtSummary extends StatefulWidget {
  const ArtSummary({super.key});

  @override
  State<ArtSummary> createState() => _ArtSummaryState();
}

// The State class - contains the mutable state and build logic
// Naming convention: underscore prefix (_) makes it private to this file
class _ArtSummaryState extends State<ArtSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar - the top navigation bar
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Art Summary',
          style: TextStyle(color: Colors.white),
        ),
      ),

      // ListView.builder - Efficient way to display a scrollable list
      // --------------------------------------------------------------
      // WHY use ListView.builder instead of ListView?
      // - It only builds items that are visible on screen (lazy loading)
      // - Better performance for large lists
      // - itemCount tells it how many items exist
      // - itemBuilder creates each item widget on demand
      body: ListView.builder(
        // Get count from our STATIC data service - shared across all screens
        itemCount: ArtDataService.getCount(),

        // itemBuilder is called for each visible item
        // 'index' is the position (0, 1, 2, ...)
        itemBuilder: (context, index) {
          // GestureDetector - Makes the child widget tappable
          // Wrapping Text in GestureDetector allows us to detect taps
          return GestureDetector(
            onTap: () async {
              // Store the tapped art's details in STATIC variables
              // This is how we pass data to the ArtDetails screen
              // Using static allows ArtDetails to access these values directly
              ArtDataService.tappedId = ArtDataService.getArtAt(index).artId;
              ArtDataService.tappedTitle = ArtDataService.getArtAt(index).title;
              ArtDataService.tappedArtist = ArtDataService.getArtAt(index).artist;
              ArtDataService.tappedImage = ArtDataService.getArtAt(index).image;

              // Navigate to art details screen
              // 'await' waits for the user to come back from that screen
              // 'arguments: index' passes the index to the details screen
              await Navigator.pushNamed(
                context,
                '/artdetails',
                arguments: index, // Pass index so details screen can delete by index
              );

              // After returning, refresh the list
              // setState() triggers a rebuild of this widget
              // This is needed because the art might have been deleted
              setState(() {});
            },

            // The visual representation of each list item
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // Access art title through STATIC method
                ArtDataService.getArtAt(index).title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),

      // Bottom button to add new art
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () async {
            // Navigate to the new art form screen
            await Navigator.pushNamed(context, '/newart');

            // After returning, refresh the list to show the new art
            setState(() {});
          },
          child: const Text('Add new art piece'),
        ),
      ),
    );
  }
}
