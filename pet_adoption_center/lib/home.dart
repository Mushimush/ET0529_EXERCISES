// Q3: Home page displaying all pets in a ListView
// Q4: Includes dialog for adding new pets

import 'package:flutter/material.dart';
import 'petdataservice.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TextEditingControllers for the dialog text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // Q4: Show dialog to add a new pet
  void _showAddPetDialog() {
    // Clear the text fields before showing dialog
    _nameController.clear();
    _breedController.clear();
    _ageController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Pet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _breedController,
                decoration: const InputDecoration(labelText: 'Breed'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
            ],
          ),
          actions: [
            // Cancel button - do nothing and return to Home page
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            // Add button - create Pet object and store in z
            TextButton(
              onPressed: () {
                // Use static method - no instance needed
                PetDataService.addPet(
                  _nameController.text,
                  _breedController.text,
                  _ageController.text,
                );
                Navigator.of(context).pop();
                // Refresh the UI to show new pet
                setState(() {});
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Adoption Center'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // ListView displaying all Pet objects
          Expanded(
            child: ListView.builder(
              itemCount: PetDataService.getCount(), // Static method call
              itemBuilder: (context, index) {
                final pet = PetDataService.getPetAt(index); // Static method call
                return ListTile(
                  // Format: "Name (Breed) - Age"
                  title: Text('${pet.name} (${pet.breed}) - ${pet.age}'),
                  // Q6: Navigate to Update Pet page when tapped
                  onTap: () async {
                    // Store tapped pet info in static variables (like Exercise 5)
                    PetDataService.tappedName = pet.name;
                    PetDataService.tappedBreed = pet.breed;
                    PetDataService.tappedAge = pet.age;
                    PetDataService.tappedIndex = index;

                    // Navigate using Named Route (like Exercise 5)
                    await Navigator.pushNamed(context, '/updatepet');
                    // Refresh the UI after returning from Update page
                    setState(() {});
                  },
                );
              },
            ),
          ),
          // Button to pop up dialog for New Pet
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _showAddPetDialog,
              child: const Text('Add New Pet'),
            ),
          ),
        ],
      ),
    );
  }
}
