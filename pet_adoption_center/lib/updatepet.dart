// Q6: Update Pet page
// Reads tapped pet info from static variables (like Exercise 5)

import 'package:flutter/material.dart';
import 'petdataservice.dart';

class UpdatePet extends StatefulWidget {
  const UpdatePet({super.key});

  @override
  State<UpdatePet> createState() => _UpdatePetState();
}

class _UpdatePetState extends State<UpdatePet> {
  // TextEditingControllers for breed and age text fields
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the text fields from static variables (like Exercise 5)
    _breedController.text = PetDataService.tappedBreed;
    _ageController.text = PetDataService.tappedAge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Pet'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Non-editable text showing the pet's name (from static variable)
            Text(
              'Name: ${PetDataService.tappedName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // TextField for new breed
            TextField(
              controller: _breedController,
              decoration: const InputDecoration(labelText: 'Breed'),
            ),
            const SizedBox(height: 16),
            // TextField for new age
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 24),
            // Update button
            ElevatedButton(
              onPressed: () {
                // Update using tappedIndex from static variable
                PetDataService.updatePetAt(
                  PetDataService.tappedIndex,
                  _breedController.text,
                  _ageController.text,
                );
                // Return to Home page
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
