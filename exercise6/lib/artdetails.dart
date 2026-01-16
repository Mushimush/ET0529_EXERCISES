import 'package:flutter/material.dart';
import 'artdataservice.dart';

class ArtDetails extends StatefulWidget {
  const ArtDetails({super.key});

  @override
  State<ArtDetails> createState() => _ArtDetailsState();
}

class _ArtDetailsState extends State<ArtDetails> {
  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Art Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Art ID: ${ArtDataService.tappedId}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Title: ${ArtDataService.tappedTitle}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Artist: ${ArtDataService.tappedArtist}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Image: ${ArtDataService.tappedImage}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (ArtDataService.tappedImage.isNotEmpty)
              Image.asset(
                'assets/images/${ArtDataService.tappedImage}',
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Image not found');
                },
              ),
            const SizedBox(height: 32),
            Row(
              children: [
                // Delete button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            'Confirm',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          content: const Text(
                            'Proceed to delete data?',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          actions: [
                            MaterialButton(
                              child: const Text('OK'),
                              onPressed: () {
                                ArtDataService.removeArtAt(index);
                                Navigator.of(context).pop(); // Close dialog
                                Navigator.of(context).pop(); // Go back to Art Summary
                              },
                            ),
                            MaterialButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog only
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Delete'),
                ),
                const SizedBox(width: 16),
                // Update button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/updateart');
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
