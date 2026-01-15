import 'art.dart';

// =============================================================================
// ArtDataService - Data Management Service Class
// =============================================================================
//
// WHY USE STATIC HERE?
// --------------------
// All members (variables and methods) in this class are STATIC because:
//
// 1. SHARED DATA ACROSS THE APP:
//    - We need ONE central list of art pieces that ALL screens can access
//    - Without static, each screen would create its own ArtDataService instance
//      with its own empty list - data would not be shared!
//
// 2. NO NEED TO CREATE OBJECTS:
//    - Static members belong to the CLASS itself, not to instances
//    - We can directly call: ArtDataService.addArt(...)
//    - Instead of: ArtDataService service = ArtDataService(); service.addArt(...)
//
// 3. DATA PERSISTENCE DURING APP LIFETIME:
//    - Static variables keep their values as long as the app is running
//    - When you navigate between screens, the data remains intact
//
// WHEN TO USE STATIC:
// -------------------
// - When you need SHARED data accessible from anywhere (like a global variable)
// - When you don't need multiple instances of a class
// - For utility/helper methods that don't depend on instance state
// - For constants that are the same for all instances
//
// WHEN NOT TO USE STATIC:
// -----------------------
// - When each object needs its own unique data (like the Art class)
// - When you need multiple independent instances
// - When data should be garbage collected when no longer needed
//
// =============================================================================

class ArtDataService {
  // -------------------------------------------------------------------------
  // STATIC VARIABLES - Shared across the entire app
  // -------------------------------------------------------------------------

  // These store the currently selected/tapped art piece's details
  // Used to pass data between ArtSummary screen and ArtDetails screen
  // Static because we need to access the SAME values from different screens
  static String tappedTitle = "";
  static String tappedArtist = "";
  static String tappedImage = "";
  static String tappedId = "";

  // The main data storage - a list that holds all Art objects
  // Static so ALL screens share the SAME list
  // If this was NOT static, each screen would have its own empty list!
  static List<Art> z = [];

  // -------------------------------------------------------------------------
  // STATIC METHODS - Can be called without creating an instance
  // -------------------------------------------------------------------------

  // CREATE - Get the total number of art pieces
  // Usage: int count = ArtDataService.getCount();
  static int getCount() {
    return z.length;
  }

  // CREATE - Add a new art piece to the list
  // Usage: ArtDataService.addArt("001", "Mona Lisa", "Da Vinci", "mona.png");
  static void addArt(String artId, String artTitle, String artArtist, String artImage) {
    z.add(Art(artId, artTitle, artArtist, artImage));
  }

  // READ - Get an art piece by its position in the list
  // Usage: Art art = ArtDataService.getArtAt(0); // Gets first art piece
  static Art getArtAt(int index) {
    return z[index];
  }

  // READ - Find an art piece by its unique ID
  // Returns null if not found
  // Usage: Art? art = ArtDataService.getArtByArtId("001");
  static Art? getArtByArtId(String id) {
    for (int i = 0; i < z.length; i++) {
      if (z[i].artId == id) {
        return z[i];
      }
    }
    return null; // Return null if no art piece found with that ID
  }

  // UPDATE - Modify an art piece at a specific index
  // Usage: ArtDataService.updateArtAt(0, "New Title", "New Artist", "new.png");
  static void updateArtAt(int index, String newTitle, String newArtist, String newImage) {
    z[index].title = newTitle;
    z[index].artist = newArtist;
    z[index].image = newImage;
  }

  // UPDATE - Modify an art piece by its ID
  // Usage: ArtDataService.updateArtByArtId("001", "New Title", "New Artist", "new.png");
  static void updateArtByArtId(String id, String newTitle, String newArtist, String newImage) {
    for (int i = 0; i < z.length; i++) {
      if (z[i].artId == id) {
        z[i].title = newTitle;
        z[i].artist = newArtist;
        z[i].image = newImage;
      }
    }
  }

  // DELETE - Remove an art piece at a specific index
  // Usage: ArtDataService.removeArtAt(0); // Removes first art piece
  static void removeArtAt(int index) {
    z.removeAt(index);
  }

  // DELETE - Remove an art piece by its ID
  // Usage: ArtDataService.removeArtByArtId("001");
  static void removeArtByArtId(String id) {
    for (int i = 0; i < z.length; i++) {
      if (z[i].artId == id) {
        z.removeAt(i);
      }
    }
  }
}
