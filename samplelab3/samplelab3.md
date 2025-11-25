# Singapore Polytechnic
## School of Electrical & Electronic Engineering
## Mobile Application Development
## 202526 Semester 1 Lab Test 3 Sample

**Official (Closed), Non-Sensitive**

---

**SAS code: LAB3(15%)**

**Admission Number:** ___________________

**Name:** ______________________________

**Class:** _______________________________

**Duration:** 90 mins

**Total Mark:** _____

---

## Q1. Develop a Movie Rating App

### Requirements:

**a)** Create a Flutter app with **2 screens** using **basic push/pop** navigation.

**b)** All 5 movies start **unrated**. The app allows users to rate each movie across 3 metrics:
   - **Plot**
   - **Characters**
   - **Cinematography**

   Each metric is rated from **1 to 5 stars**.

**c)** After rating all 3 metrics for a movie, calculate and display the **average rating** for that movie (2 decimal places).


---

## Screen 1 - Movie List

The UI consists of:

- **AppBar** showing "Movie Ratings by `<your name>`"

- **Image** "movies.png" displayed at the top of the screen

- **ListView** with 5 movies displayed using **ListTile**:
  - **Leading:** `Icon(Icons.movie)`
  - **Title:** Movie name (Text widget)
  - **Subtitle:**
    - If not rated: Display "Not rated yet"
    - If rated: Display "Average: X.XX ★"
  - **Trailing:** `IconButton` with `Icon(Icons.arrow_forward)` to navigate to rating screen

**The 5 movies are:**
1. Inception
2. Avatar
3. Titanic
4. Interstellar
5. The Matrix

---

## Screen 2 - Rate Movie

The UI consists of:

- **AppBar** showing the movie name (passed via constructor parameter) with automatic back button

- **Text widget** displaying "Rate: `<Movie Name>`" with font size 24 and bold

- **Three rows for the three metrics**, each row contains:
  - **Text label** for the metric name (e.g., "Plot:")
  - **Row of 5 star IconButtons** to select rating (1-5 stars)

  ```
  Plot:           ☆ ☆ ☆ ☆ ☆
  Characters:     ☆ ☆ ☆ ☆ ☆
  Cinematography: ☆ ☆ ☆ ☆ ☆
  ```

- **Star IconButton behavior:**
  - **Unselected:** `Icon(Icons.star_border, color: Colors.grey)`
  - **Selected:** `Icon(Icons.star, color: Colors.amber)`
  - Clicking a star fills all stars from left up to and including that star
    - Example: Click 3rd star → ★★★☆☆ (3 stars selected)
    - Example: Click 5th star → ★★★★★ (5 stars selected)

- **OutlinedButton** with text "Clear Rating"
  - Resets all 3 metrics to 0 stars (unselected)
  - Displays **SnackBar** with message "Ratings cleared"

- **FilledButton** with text "Submit Rating"

- **Validation when Submit Rating is clicked:**
  - If **any metric has 0 stars selected** (not rated):
    - Display **SnackBar** with message "Please rate all metrics"
    - Do NOT navigate back
  - If **all 3 metrics are rated** (each has 1-5 stars):
    - Calculate average rating: `(plot + characters + cinematography) / 3`
    - Display **Text widget** below button showing "Movie Average: X.XX ★"
    - Display **SnackBar** with message "Rating submitted! Average: X.XX stars"
    - Navigate back to Screen 1 using `Navigator.pop()` after 1 second
    - Screen 1 should show the updated rating in the ListView

---

## Sample Outputs

### Screen 1 - Initial State (No ratings):

```
┌─────────────────────────────────────┐
│ Movie Ratings by John Tan           │
└─────────────────────────────────────┘

[movies.png image]

┌─────────────────────────────────────┐
│ 🎬  Inception                      →│
│     Not rated yet                   │
├─────────────────────────────────────┤
│ 🎬  Avatar                         →│
│     Not rated yet                   │
├─────────────────────────────────────┤
│ 🎬  Titanic                        →│
│     Not rated yet                   │
├─────────────────────────────────────┤
│ 🎬  Interstellar                   →│
│     Not rated yet                   │
├─────────────────────────────────────┤
│ 🎬  The Matrix                     →│
│     Not rated yet                   │
└─────────────────────────────────────┘
```

---

### Screen 1 - After rating 2 movies:

**Example calculations:**
- **Inception:** Plot=5, Characters=4, Cinematography=5 → Average = (5+4+5)/3 = 4.67 stars
- **Avatar:** Plot=3, Characters=4, Cinematography=5 → Average = (3+4+5)/3 = 4.00 stars

```
┌─────────────────────────────────────┐
│ Movie Ratings by John Tan           │
└─────────────────────────────────────┘

[movies.png image]

┌─────────────────────────────────────┐
│ 🎬  Inception                      →│
│     Average: 4.67 ★                 │
├─────────────────────────────────────┤
│ 🎬  Avatar                         →│
│     Average: 4.00 ★                 │
├─────────────────────────────────────┤
│ 🎬  Titanic                        →│
│     Not rated yet                   │
├─────────────────────────────────────┤
│ 🎬  Interstellar                   →│
│     Not rated yet                   │
├─────────────────────────────────────┤
│ 🎬  The Matrix                     →│
│     Not rated yet                   │
└─────────────────────────────────────┘
```

---

### Screen 2 - Rating a Movie (Before selection):

```
┌─────────────────────────────────────┐
│ ← Inception                         │
└─────────────────────────────────────┘

Rate: Inception

Plot:           ☆ ☆ ☆ ☆ ☆

Characters:     ☆ ☆ ☆ ☆ ☆

Cinematography: ☆ ☆ ☆ ☆ ☆


┌─────────────────────┐  ┌─────────────────────┐
│   Clear Rating      │  │   Submit Rating     │
└─────────────────────┘  └─────────────────────┘
```

---

### Screen 2 - After selecting ratings:

**User selected:**
- Plot: 5 stars (clicked 5th star)
- Characters: 4 stars (clicked 4th star)
- Cinematography: 5 stars (clicked 5th star)

```
┌─────────────────────────────────────┐
│ ← Inception                         │
└─────────────────────────────────────┘

Rate: Inception

Plot:           ★ ★ ★ ★ ★

Characters:     ★ ★ ★ ★ ☆

Cinematography: ★ ★ ★ ★ ★


┌─────────────────────┐  ┌─────────────────────┐
│   Clear Rating      │  │   Submit Rating     │
└─────────────────────┘  └─────────────────────┘

Movie Average: 4.67 ★

─────────────────────────────────────
SnackBar: "Rating submitted! Average: 4.67 stars"
─────────────────────────────────────
```

*(After 1 second, navigates back to Screen 1)*

---

### Screen 2 - Validation Error:

**User clicked Submit without rating all metrics:**

```
Plot:           ★ ★ ★ ★ ★  (rated)

Characters:     ☆ ☆ ☆ ☆ ☆  (NOT rated - 0 stars)

Cinematography: ★ ★ ★ ★ ☆  (rated)

─────────────────────────────────────
SnackBar: "Please rate all metrics"
─────────────────────────────────────
```

*(User stays on Screen 2, does NOT navigate back)*

---

## Additional Requirements:

**f)** Users **can re-rate** a movie. If a movie is already rated and user rates it again, the new rating **replaces** the old rating.

**g)** Use **basic push/pop** for navigation:
   - Use `Navigator.push()` with `MaterialPageRoute` to navigate to Screen 2
   - Pass the Movie object to Screen 2 via constructor parameter
   - Use `Navigator.pop()` to return to Screen 1

**h)** Use **Padding** widget appropriately for spacing between UI elements.

**i)** Implement proper **state management** to update ratings when returning from Screen 2 to Screen 1.

**j)** Test your code with the selected device set to **"Chrome web"**.

---

## Icons and Widgets to Use:

```dart
// Icons
Icon movieIcon = const Icon(Icons.movie);
Icon forwardIcon = const Icon(Icons.arrow_forward);
Icon starFilled = const Icon(Icons.star, color: Colors.amber);
Icon starEmpty = const Icon(Icons.star_border, color: Colors.grey);

// Example of using IconButton for stars
IconButton(
  icon: Icon(Icons.star, color: Colors.amber),
  onPressed: () {
    // Handle star selection
  },
)
```

---

## Image Asset Setup:

Include `movies.png` in your project:

1. Create folder structure: `assets/images/`
2. Place `movies.png` in `assets/images/` directory
3. Update `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/movies.png
```

4. Use in code:
```dart
Image.asset('assets/images/movies.png', height: 150)
```

---

## Data Structure Suggestion:

```dart
class Movie {
  String name;
  int? plotRating;         // null if not rated, 1-5 if rated
  int? charactersRating;   // null if not rated, 1-5 if rated
  int? cinematographyRating; // null if not rated, 1-5 if rated

  Movie(this.name);

  // Method to check if movie is fully rated
  bool isRated() {
    return plotRating != null &&
           charactersRating != null &&
           cinematographyRating != null;
  }

  // Method to calculate average (returns null if not fully rated)
  double? getAverage() {
    if (!isRated()) return null;
    return (plotRating! + charactersRating! + cinematographyRating!) / 3;
  }
}
```

---

## Calculation Examples:

### Example 1: Single movie average
```
Plot:           5 stars
Characters:     4 stars
Cinematography: 5 stars

Average = (5 + 4 + 5) / 3 = 14 / 3 = 4.666... ≈ 4.67
```

### Example 2: Formatting to 2 decimal places in Dart
```dart
double average = 4.666666;
String formatted = average.toStringAsFixed(2); // "4.67"
```

---

## Key Concepts Tested:

✅ **ListTile widget** - Displaying movie list with leading, title, subtitle, trailing

✅ **ListView widget** - Scrollable list of movies

✅ **Navigation** - Basic push/pop, passing data via constructor, Navigator.pop()

✅ **IconButton widget** - Interactive star rating buttons

✅ **SnackBar** - Validation feedback messages

✅ **Padding** - Layout spacing

✅ **State management** - Updating ratings and refreshing UI

✅ **Arithmetic calculations** - Computing averages with 2 decimal places

✅ **Conditional display** - Showing different text based on rating status

✅ **Image assets** - Including and displaying images

✅ **Stateful widgets** - Managing interactive UI state

---

## Grading Rubric (Total: 15 marks)

| Component | Marks | Description |
|-----------|-------|-------------|
| **Screen 1 UI** | 3 | AppBar, Image, ListView with ListTile (leading, title, subtitle, trailing) |
| **Screen 2 UI** | 3 | AppBar, Movie name display, 3 metric rows with star IconButtons, Clear Rating and Submit Rating buttons |
| **Star Selection Logic** | 2 | IconButtons work correctly, visual feedback (filled/unfilled stars), clicking star fills up to that star |
| **Navigation** | 2 | Navigator.push() with MaterialPageRoute, passing Movie via constructor, Navigator.pop() back to Screen 1 |
| **Validation** | 1 | SnackBar shows error if any metric not rated, prevents navigation |
| **Average Calculation** | 2 | Movie average calculated correctly (2 decimal places) |
| **State Management** | 1 | Ratings persist and display correctly when returning to Screen 1 |
| **SnackBar Success** | 1 | Success message shows with correct average on submission, Clear Rating shows "Ratings cleared" |

---

## Tips for Students:

1. **Start with Screen 1** - Create the ListView with hardcoded movie names first
2. **Add navigation** - Make the arrow buttons navigate to Screen 2
3. **Build Screen 2 UI** - Focus on layout before adding interactivity
4. **Implement star selection** - Start with one metric row, then replicate
5. **Add validation** - Check if all metrics are rated before calculating
6. **Calculate averages** - Use `toStringAsFixed(2)` for formatting
7. **Update state** - Use `setState()` to refresh UI after rating
8. **Test thoroughly** - Rate multiple movies and verify calculations

---

## Common Mistakes to Avoid:

❌ Forgetting to include image asset in `pubspec.yaml`

❌ Not formatting averages to 2 decimal places

❌ Not using `setState()` when updating ratings

❌ SnackBar disappearing too quickly (use duration parameter)

❌ Not passing Movie object to Screen 2 via constructor parameter

❌ Calculating average incorrectly (dividing by wrong number)

❌ Not validating that all 3 metrics are rated before submission

❌ Forgetting to implement Clear Rating button functionality

---

**End of Lab Test 3 Sample**

Test your code with selected device set to "Chrome web".
