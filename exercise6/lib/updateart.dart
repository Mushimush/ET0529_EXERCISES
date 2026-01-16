import 'package:flutter/material.dart';
import 'artdataservice.dart';

class UpdateArt extends StatefulWidget {
  const UpdateArt({super.key});

  @override
  State<UpdateArt> createState() => _UpdateArtState();
}

class _UpdateArtState extends State<UpdateArt> {
  // Controllers for editable fields
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerArtist = TextEditingController();
  final TextEditingController controllerImage = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill with current values from tapped art
    controllerTitle.text = ArtDataService.tappedTitle;
    controllerArtist.text = ArtDataService.tappedArtist;
    controllerImage.text = ArtDataService.tappedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Update Art Piece',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Art ID (not editable)
            Text(
              'Art ID: ${ArtDataService.tappedId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // TextField for Title
            TextField(
              controller: controllerTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // TextField for Artist
            TextField(
              controller: controllerArtist,
              decoration: const InputDecoration(
                labelText: 'Artist',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // TextField for Image Filename
            TextField(
              controller: controllerImage,
              decoration: const InputDecoration(
                labelText: 'Image Filename',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Update button
            Center(
              child: FilledButton(
                onPressed: () {
                  // Update art using artId
                  ArtDataService.updateArtByArtId(
                    ArtDataService.tappedId,
                    controllerTitle.text,
                    controllerArtist.text,
                    controllerImage.text,
                  );

                  // Navigate back to ArtSummary (pop twice: UpdateArt -> ArtDetails -> ArtSummary)
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
