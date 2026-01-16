# Exercise 5 - Art Gallery CRUD App (Local Storage)

## Overview

This is an Art Gallery app that demonstrates **CRUD operations** (Create, Read, Update, Delete) using **local storage** (in-memory List).

**Note:** Data is stored in RAM only - it will be **lost when the app closes**.

---

## Key Concepts Covered

### 1. CRUD Operations

| Operation | Method | Description |
|-----------|--------|-------------|
| **C**reate | `addArt()` | Add new art to the list |
| **R**ead | `getArtAt()`, `getArtByArtId()` | Retrieve art from the list |
| **U**pdate | `updateArtAt()`, `updateArtByArtId()` | Modify existing art |
| **D**elete | `removeArtAt()`, `removeArtByArtId()` | Remove art from the list |

### 2. Static Keyword

All members in `ArtDataService` are **static** because:

```dart
// WHY STATIC?
class ArtDataService {
  static List<Art> z = [];  // Shared across ALL screens

  static void addArt(...) { ... }
}

// Usage - No need to create an instance:
ArtDataService.addArt("CM1", "Mona Lisa", "Da Vinci", "mona.png");
```

**Benefits of Static:**
- Shared data accessible from any screen
- No need to create objects
- Data persists during app lifetime

### 3. Model Class (Art)

```dart
class Art {
  String artId;    // Unique identifier (e.g., "CM1")
  String title;    // Art title
  String artist;   // Artist name
  String image;    // Image filename
}
```

### 4. Navigation with Named Routes

```dart
// In main.dart - Define routes
routes: {
  '/': (context) => ArtSummary(),
  '/newart': (context) => NewArt(),
  '/artdetails': (context) => ArtDetails(),
}

// Navigate to a screen
Navigator.pushNamed(context, '/artdetails');

// Go back
Navigator.pop(context);
```

### 5. ListView.builder

Efficiently displays a scrollable list:

```dart
ListView.builder(
  itemCount: ArtDataService.getCount(),
  itemBuilder: (context, index) {
    Art art = ArtDataService.getArtAt(index);
    return Text(art.title);
  },
)
```

### 6. GestureDetector

Makes any widget tappable:

```dart
GestureDetector(
  onTap: () {
    // Handle tap
    Navigator.pushNamed(context, '/artdetails');
  },
  child: Text("Tap me"),
)
```

### 7. TextEditingController

Gets user input from TextField:

```dart
final controller = TextEditingController();

TextField(controller: controller)

// Get the text
String userInput = controller.text;
```

### 8. AlertDialog

Confirmation popup before delete:

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Confirm'),
    content: Text('Delete this art?'),
    actions: [
      TextButton(onPressed: () { /* delete */ }, child: Text('OK')),
      TextButton(onPressed: () { Navigator.pop(context); }, child: Text('Cancel')),
    ],
  ),
);
```

### 9. setState

Refreshes the UI when data changes:

```dart
setState(() {
  // UI will rebuild after this
});
```

---

## File Structure

```
lib/
├── art.dart           # Art model class
├── artdataservice.dart # Data storage & CRUD methods (static)
├── artsummary.dart    # Home screen - list of art titles
├── artdetails.dart    # Detail screen - shows art info + delete
├── newart.dart        # Form to add new art
└── main.dart          # App entry point + routes
```

---

## App Flow

```
┌─────────────────┐
│   ArtSummary    │
│                 │
│  - Sunflowers   │──── Tap ────►┌─────────────────┐
│  - Woman with.. │              │   ArtDetails    │
│                 │              │                 │
│ [Add new art]───┼──────────►   │  [Image]        │
└─────────────────┘              │  Title: ...     │
        │                        │  Artist: ...    │
        │                        │                 │
        ▼                        │  [Delete]       │
┌─────────────────┐              └─────────────────┘
│     NewArt      │
│                 │
│  ArtID: [____]  │
│  Title: [____]  │
│  Artist: [____] │
│  Image:  [____] │
│                 │
│     [Add]       │
└─────────────────┘
```

---

## Limitations

- **No persistence** - Data is lost when app closes
- **No cloud sync** - Data only exists on local device

**Solution:** See Exercise 6 for Firebase integration!
