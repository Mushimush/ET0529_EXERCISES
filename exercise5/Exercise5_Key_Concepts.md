# Exercise 5.1 - Key Concepts for Beginners

## What is this app about?

This is an **Art Gallery App** where you can:
- Add new art pieces
- View a list of all art pieces
- Tap on an art piece to see its details
- Delete an art piece

---

## Key Concept 1: The Art Model

Think of a **model** as a template. Every art piece has the same information:

```dart
class Art {
  String artId;    // e.g., "CM1"
  String title;    // e.g., "Woman with a Parasol"
  String artist;   // e.g., "Claude Monet"
  String image;    // e.g., "parasol.png"
}
```

**File:** `lib/art.dart`

---

## Key Concept 2: Data Service (Storing Data)

We need a place to **store all our art pieces**. We use a List (like an array).

```dart
class ArtDataService {
  static List<Art> z = [];  // This stores all art pieces
}
```

The data service has **helper methods**:

| Method | What it does |
|--------|--------------|
| `addArt()` | Add a new art piece to the list |
| `getArtAt(index)` | Get an art piece by position (0, 1, 2...) |
| `getCount()` | How many art pieces do we have? |
| `removeArtAt(index)` | Delete an art piece |

**File:** `lib/artdataservice.dart`

---

## Key Concept 3: Multiple Screens (Pages)

This app has **3 screens**:

| Screen | Purpose | File |
|--------|---------|------|
| Art Summary | Shows list of all art titles | `artsummary.dart` |
| Art Details | Shows one art piece with image | `artdetails.dart` |
| New Art | Form to add a new art piece | `newart.dart` |

---

## Key Concept 4: Navigation (Moving Between Screens)

**To go to another screen:**
```dart
Navigator.pushNamed(context, '/artdetails');
```

**To go back:**
```dart
Navigator.pop(context);
```

---

## Key Concept 5: ListView.builder

Used to display a **list of items** that can scroll:

```dart
ListView.builder(
  itemCount: ArtDataService.getCount(),  // How many items?
  itemBuilder: (context, index) {
    return Text(ArtDataService.getArtAt(index).title);
  },
)
```

---

## Key Concept 6: GestureDetector (Tap to Do Something)

Wrap any widget to make it **tappable**:

```dart
GestureDetector(
  onTap: () {
    // This code runs when user taps
    print("You tapped!");
  },
  child: Text("Tap me"),
)
```

---

## Key Concept 7: TextEditingController (Getting User Input)

Used with **TextField** to get what the user types:

```dart
// Step 1: Create controller
final TextEditingController controllerTitle = TextEditingController();

// Step 2: Connect to TextField
TextField(
  controller: controllerTitle,
)

// Step 3: Get the text
String userTyped = controllerTitle.text;
```

---

## Key Concept 8: AlertDialog (Confirmation Popup)

Ask the user **"Are you sure?"** before deleting:

```dart
showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
      title: Text('Confirm'),
      content: Text('Delete this art?'),
      actions: [
        TextButton(
          onPressed: () {
            // Delete the art
            Navigator.pop(context);  // Close dialog
          },
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);  // Just close dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  },
);
```

---

## Key Concept 9: Displaying Images

**Step 1:** Put images in `assets/images/` folder

**Step 2:** Tell Flutter about them in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
```

**Step 3:** Display the image:
```dart
Image.asset('assets/images/parasol.png')
```

---

## Key Concept 10: setState (Refresh the Screen)

When data changes, call `setState()` to **update the screen**:

```dart
setState(() {
  // Screen will refresh after this
});
```

---

## How the App Flows

```
+------------------+
|   Art Summary    |
|                  |
|  - Sunflowers    |  <-- Tap to see details
|  - Woman with... |
|                  |
| [Add new art]    |  <-- Tap to add new
+------------------+
        |
        v
+------------------+       +------------------+
|   Art Details    |       |    New Art       |
|                  |       |                  |
|  [Image]         |       |  ArtID: [____]   |
|  Title: ...      |       |  Title: [____]   |
|  Artist: ...     |       |  Artist: [____]  |
|                  |       |  Image:  [____]  |
|  [Delete]        |       |                  |
+------------------+       |  [Add]           |
                           +------------------+
```

---

## Quick Start for Students

1. Create a new Flutter project
2. Create `lib/art.dart` - the Art class
3. Create `lib/artdataservice.dart` - to store data
4. Create `lib/artsummary.dart` - the main list screen
5. Create `lib/newart.dart` - form to add art
6. Create `lib/artdetails.dart` - show art details
7. Set up routes in `lib/main.dart`
8. Add images to `assets/images/` folder
9. Update `pubspec.yaml` to include assets
10. Run and test!

---

## Remember!

- **Model** = Template for data (Art class)
- **Data Service** = Where we store and manage data
- **Navigator** = Move between screens
- **setState** = Refresh the screen when data changes
- **Controller** = Get text from TextField
