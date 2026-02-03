// Q2: PetDataService class to manage Pet objects
// Using STATIC like Exercise 5 - data shared across all screens

import 'pet.dart';

class PetDataService {
  // Static variables to store the tapped pet's info (like Exercise 5)
  // These "remember" which pet was clicked when navigating to Update page
  static String tappedName = "";
  static String tappedBreed = "";
  static String tappedAge = "";
  static int tappedIndex = 0;

  // Static list to store all Pet objects - shared across all screens
  static List<Pet> z = [];

  // Returns the number of Pet objects in z
  static int getCount() {
    return z.length;
  }

  // Takes in 3 strings (name, breed, age), creates a Pet object, and stores it in z
  static void addPet(String name, String breed, String age) {
    Pet newPet = Pet(name, breed, age);
    z.add(newPet);
  }

  // Takes in an index and returns the Pet object at that indexed location from z
  static Pet getPetAt(int index) {
    return z[index];
  }

  // Q6: Update pet's breed and age at the given index
  static void updatePetAt(int index, String breed, String age) {
    z[index].breed = breed;
    z[index].age = age;
  }
}
