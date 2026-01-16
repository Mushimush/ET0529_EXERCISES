# Exercise 6 - Art Gallery CRUD App with Firebase

## Overview

This is an Art Gallery app that demonstrates **CRUD operations** with **Firebase Firestore** cloud storage.

**Key Feature:** Data **persists** even after the app closes - stored in the cloud!

---

## Key Concepts Covered

### 1. async / await

Firebase operations communicate with external cloud servers. We use `async`/`await` to handle this.

```dart
// WHY DO WE NEED ASYNC/AWAIT?
// Firebase operations take unpredictable time (network latency, server processing)
// We must WAIT for Firebase to complete before continuing

void main() async {                    // 'async' - this function uses await
  await Firebase.initializeApp();      // 'await' - wait for Firebase to initialize
  await ArtDataService.getAllArts();   // 'await' - wait for data to load
  runApp(MyApp());                     // Only runs AFTER both are complete
}
```

**Without await (BUG):**
```
App: "Save this data"
App: "Next task!" (too early!)
Firebase: "Still working..."
```

**With await (CORRECT):**
```
App: "Save this data"
App: *waiting...*
Firebase: "Done!"
App: "Next task!"
```

### 2. Future<void>

When a function needs to be awaited by its **caller**, use `Future<void>`:

```dart
// With 'void' - caller CANNOT wait
static void loadData() async { ... }
loadData();  // Cannot use await here!

// With 'Future<void>' - caller CAN wait
static Future<void> loadData() async { ... }
await loadData();  // This works!
```

### 3. Local Storage vs Cloud Storage

| Variable | Type | Speed | Persistence |
|----------|------|-------|-------------|
| `z` | List<Art> (RAM) | Instant | Lost on app close |
| `artData` | Firestore Collection | Slow (network) | Persists forever |

**Why use both?**
```
App Start:     Firestore ──load──> z (getAllArts)
Add/Delete:    z (fast UI) + Firestore (save to cloud)
```

### 4. Firestore CRUD Operations

```dart
// Reference to Firestore collection
static CollectionReference artData =
    FirebaseFirestore.instance.collection('artdata');

// CREATE - Add document
await artData.add({
  'artId': artId,
  'title': title,
  'artist': artist,
  'image': image,
});

// READ - Get all documents
QuerySnapshot qs = await artData.get();

// UPDATE - Find and update document
QuerySnapshot qs = await artData.where("artId", isEqualTo: id).get();
doc.reference.update({'title': newTitle});

// DELETE - Find and delete document
QuerySnapshot qs = await artData.where("artId", isEqualTo: id).get();
doc.reference.delete();
```

### 5. Firestore Query Explained

```dart
QuerySnapshot qs = await artData.limit(1).where("artId", isEqualTo: idToDelete).get();
```

| Part | What it does |
|------|--------------|
| `artData` | The 'artdata' collection in Firestore |
| `.where("artId", isEqualTo: idToDelete)` | Filter: find docs where artId matches |
| `.limit(1)` | Only get 1 result (more efficient) |
| `.get()` | Execute query, fetch results |
| `await` | Wait for Firestore to respond |

### 6. Map<String, dynamic>

Firestore returns data as a Map:

```dart
Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

// Access fields using keys
String title = data['title'];
String artist = data['artist'];
```

---

## File Structure

```
lib/
├── art.dart              # Art model class
├── artdataservice.dart   # CRUD with local + Firestore (async/await)
├── artsummary.dart       # Home screen - list of art titles
├── artdetails.dart       # Detail screen - delete + update buttons
├── newart.dart           # Form to add new art
├── updateart.dart        # Form to update existing art (Exercise 6.1)
├── firebase_options.dart # Auto-generated Firebase config
└── main.dart             # App entry + Firebase initialization
```

---

## Exercise 6.1 - Update Feature

Added an **Update** button to the ArtDetails page:

```
ArtDetails                    UpdateArt
┌─────────────────┐           ┌─────────────────┐
│  [Image]        │           │  Art ID: CM1    │ (not editable)
│  Title: ...     │           │                 │
│  Artist: ...    │  ──────►  │  Title: [____]  │
│                 │           │  Artist: [____] │
│ [Delete][Update]│           │  Image:  [____] │
└─────────────────┘           │                 │
                              │    [Update]     │
                              └─────────────────┘
```

---

## Firebase Setup Required

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Firestore Database
3. Create collection named `artdata` with fields:
   - `artId` (string)
   - `title` (string)
   - `artist` (string)
   - `image` (string)
4. Run `flutterfire configure` to generate `firebase_options.dart`

---

## Data Flow

```
┌─────────────┐                    ┌─────────────────┐
│   App       │                    │   Firestore     │
│             │                    │   (Cloud)       │
│  List<Art>  │◄───── getAllArts ──│   artdata       │
│      z      │                    │   collection    │
│             │────── addArt ─────►│                 │
│             │────── removeArt ──►│                 │
│             │────── updateArt ──►│                 │
└─────────────┘                    └─────────────────┘
     LOCAL                              CLOUD
   (fast, temporary)              (slow, persistent)
```

---

## Comparison: Exercise 5 vs Exercise 6

| Feature | Exercise 5 | Exercise 6 |
|---------|------------|------------|
| Storage | Local (RAM) | Local + Cloud (Firestore) |
| Persistence | Lost on app close | Persists forever |
| async/await | Not needed | Required for all Firebase ops |
| Update feature | No | Yes (Exercise 6.1) |
| Internet required | No | Yes |
