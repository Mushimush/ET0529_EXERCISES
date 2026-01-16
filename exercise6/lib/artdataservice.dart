import 'art.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =============================================================================
// ArtDataService - Data Management with Firebase Firestore
// =============================================================================
//
// This class handles CRUD operations for both:
// 1. Local storage (List<Art> z) - for fast UI updates
// 2. Cloud storage (Firestore) - for data persistence
//
// ASYNC/AWAIT IN THIS CLASS:
// --------------------------
// All methods that interact with Firestore use 'async' and 'await' because:
// - Firestore is an external cloud database
// - Network operations take unpredictable time
// - We must WAIT for Firestore to complete before continuing
//
// PATTERN USED:
// -------------
//   static void methodName() async {
//     z.doSomething();                    // Local operation (instant)
//     await artData.doSomething();        // Firebase operation (needs waiting)
//   }
//
// FUTURE<void> RETURN TYPE:
// -------------------------
// When a function needs to be 'await'-ed by its CALLER, we use Future<void>.
//
// WHAT IS A FUTURE?
// A Future represents a value that will be available "in the future".
// Think of it like a promise: "I will give you something later".
//
// Future<void> = "I promise to finish later, but I won't return any value"
// Future<String> = "I promise to give you a String later"
// Future<int> = "I promise to give you an int later"
//
// WHY DO WE NEED IT?
// ------------------
// Compare these two function signatures:
//
//   static void doSomething() async { ... }
//   static Future<void> doSomething() async { ... }
//
// Both can use 'await' INSIDE them. But only Future<void> can be
// awaited BY THE CALLER.
//
// EXAMPLE:
// --------
//   // With 'void' return type:
//   static void loadData() async {
//     await artData.get();  // Can use await inside - OK
//   }
//
//   void main() async {
//     loadData();           // Cannot await - main() won't wait!
//     runApp();             // App starts before data is loaded - BUG!
//   }
//
//   // With 'Future<void>' return type:
//   static Future<void> loadData() async {
//     await artData.get();  // Can use await inside - OK
//   }
//
//   void main() async {
//     await loadData();     // CAN await - main() waits for completion!
//     runApp();             // App starts AFTER data is loaded - CORRECT!
//   }
//
// SUMMARY:
// --------
// - Use 'void' if the caller does NOT need to wait
// - Use 'Future<void>' if the caller NEEDS to wait for completion
//
// =============================================================================

class ArtDataService {
  // Store currently tapped art details for passing between screens
  static String tappedTitle = "";
  static String tappedArtist = "";
  static String tappedImage = "";
  static String tappedId = "";

  // LOCAL STORAGE (in-memory)
  // --------------------------
  // 'z' is a List that stores Art objects in the device's RAM.
  // - Fast to read/write (instant)
  // - Data is LOST when app closes
  // - Used by UI screens (ArtSummary, ArtDetails) to display data quickly
  static List<Art> z = [];

  // CLOUD STORAGE (Firestore)
  // -------------------------
  // 'artData' is a reference to the 'artdata' collection in Firebase Firestore.
  // - Slower to read/write (network delay)
  // - Data PERSISTS even after app closes
  // - Requires async/await for all operations
  static CollectionReference artData =
      FirebaseFirestore.instance.collection('artdata');

  // WHY BOTH?
  // ---------
  // We use BOTH local (z) and cloud (artData) storage:
  // 1. On app start: Load from Firestore -> Store in z (getAllArts)
  // 2. On add/update/delete: Update z (fast UI) AND Firestore (persist data)
  // This gives us: Fast UI + Persistent data

  // READ - Get count of art pieces
  static int getCount() {
    return z.length;
  }

  // READ - Get art at specific index
  static Art getArtAt(int index) {
    return z[index];
  }

  // READ - Get art by artId
  static Art? getArtByArtId(String artId) {
    for (int i = 0; i < z.length; i++) {
      if (z[i].artId == artId) {
        return z[i];
      }
    }
    return null;
  }

  // CREATE - Add new art to local storage and Firestore
  // 'async' is required because we use 'await' inside this function
  static void addArt(
      String artId, String artTitle, String artArtist, String artImage) async {
    // Local operation - instant, no waiting needed
    z.add(Art(artId, artTitle, artArtist, artImage));

    // Firebase operation - 'await' waits for cloud server to finish
    // Without 'await', the function would end before data is saved!
    await artData.add({
      'artId': artId,
      'title': artTitle,
      'artist': artArtist,
      'image': artImage,
    });
  }

  // DELETE - Remove art at index from local storage and Firestore
  static void removeArtAt(int index) async {
    // Get artId before removing from local storage
    String idToDelete = z[index].artId;

    // Remove from local storage
    z.removeAt(index);

    // Search and delete from Firestore
    // ---------------------------------
    // artData                  = the 'artdata' collection in Firestore
    // .where("artId", isEqualTo: idToDelete)  = filter: find documents where artId matches
    // .limit(1)                = only get 1 result (more efficient)
    // .get()                   = execute the query and fetch results
    // await                    = wait for Firestore to return the results
    //
    // QuerySnapshot = contains all matching documents from the query
    QuerySnapshot qs =
        await artData.limit(1).where("artId", isEqualTo: idToDelete).get();

    // qs.docs[0]       = get the first (and only) document from results
    // doc.reference    = get a reference to this document's location in Firestore
    // .delete()        = delete this document from Firestore
    DocumentSnapshot doc = qs.docs[0];
    doc.reference.delete();
  }

  // DELETE - Remove art by artId from local storage and Firestore
  static void removeArtByArtId(String idToDelete) async {
    for (int i = 0; i < z.length; i++) {
      if (z[i].artId == idToDelete) {
        // Remove from local storage
        z.removeAt(i);

        // Search and delete from Firestore
        QuerySnapshot qs =
            await artData.limit(1).where("artId", isEqualTo: idToDelete).get();
        DocumentSnapshot doc = qs.docs[0];
        doc.reference.delete();
        break;
      }
    }
  }

  // UPDATE - Update art at index in local storage and Firestore
  static void updateArtAt(
      int index, String newTitle, String newArtist, String newImage) async {
    // Update local storage
    z[index].title = newTitle;
    z[index].artist = newArtist;
    z[index].image = newImage;

    // Get artId from local storage
    String idToUpdate = z[index].artId;

    // Search and update in Firestore
    QuerySnapshot qs =
        await artData.limit(1).where("artId", isEqualTo: idToUpdate).get();
    DocumentSnapshot doc = qs.docs[0];
    doc.reference.update({
      'title': newTitle,
      'artist': newArtist,
      'image': newImage,
    });
  }

  // UPDATE - Update art by artId in local storage and Firestore
  static void updateArtByArtId(
      String idToUpdate, String newTitle, String newArtist, String newImage) async {
    for (int i = 0; i < z.length; i++) {
      if (z[i].artId == idToUpdate) {
        // Update local storage
        z[i].title = newTitle;
        z[i].artist = newArtist;
        z[i].image = newImage;

        // Search and update in Firestore
        QuerySnapshot qs =
            await artData.limit(1).where("artId", isEqualTo: idToUpdate).get();
        DocumentSnapshot doc = qs.docs[0];
        doc.reference.update({
          'title': newTitle,
          'artist': newArtist,
          'image': newImage,
        });
        break;
      }
    }
  }

  // READ ALL - Load all art from Firestore into local storage
  // Called in main() before runApp()
  //
  // WHY Future<void> instead of just void?
  // --------------------------------------
  // Future<void> allows the CALLER to use 'await' on this function.
  // In main(), we need: await ArtDataService.getAllArts();
  // This ensures all data is loaded BEFORE the app starts.
  // If we used 'void', main() couldn't wait for this to finish!
  //
  static Future<void> getAllArts() async {
    // Clear local storage
    z.clear();

    // 'await' - Wait for Firestore to return all documents
    QuerySnapshot qs = await artData.get();

    // Loop through documents and create Art objects
    // This runs only AFTER the await above completes
    for (int i = 0; i < qs.docs.length; i++) {
      DocumentSnapshot doc = qs.docs[i];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      z.add(Art(data['artId'], data['title'], data['artist'], data['image']));
    }
  }
}
