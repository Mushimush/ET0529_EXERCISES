Singapore Polytechnic

School of Electrical & Electronic Engineering

Mobile Application Development

202526 Semester 2 Lab Test 1
Sample 3

---

## Q1. Develop a Movie Rating App

**a)** Create a Flutter app with **2 screens** using **basic push/pop** navigation.

**b)** All 5 movies start **unrated**. The app allows users to rate each movie across 3 metrics:
   - Plot
   - Characters
   - Cinematography

   Each metric is rated from **1 to 5 stars**.

**c)** After rating all 3 metrics for a movie, calculate and display the **average rating** for that movie (2 decimal places).

---

## Movie Class

Create a `Movie` class in `lib/models/movie.dart`:

```dart
class Movie {
  String name;
  int? plotRating;           // null if not rated, 1-5 if rated
  int? charactersRating;     // TODO: declare this property
  int? cinematographyRating; // TODO: declare this property

  Movie(this.name);

  // Check if movie is fully rated (all 3 metrics have values)
  bool isRated() {
    // TODO: return true if ALL three ratings are not null
  }

  // Calculate average (returns null if not fully rated)
  double? getAverage() {
    // TODO: if not rated, return null
    // TODO: otherwise, calculate and return the average of the 3 ratings
  }
}
```

**Usage:**
- `movie.isRated()` returns `true` if all 3 metrics are rated
- `movie.getAverage()` returns the average as a `double`, or `null` if not fully rated
- Format average to 2 decimal places: `average.toStringAsFixed(2)`

---

## Screen 1 - Movie List

The UI consists of:
- An **AppBar** showing "Movie Ratings by `<your name>`"

In the body of the screen, the following items appear from top to bottom, in this sequence:
1. The **Image** "movies.png"
2. A **ListView** with 5 movies displayed using **ListTile**:
   - **Leading:** `Icon(Icons.movie)`
   - **Title:** Movie name (Text widget)
   - **Subtitle:**
     - If not rated: Display "Not rated yet"
     - If rated: Display "Average: X.XX ★" (2 decimal places)
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
- An **AppBar** showing the movie name (passed via constructor parameter) with automatic back button

In the body of the screen, the following items appear from top to bottom, in this sequence:
1. A **Text widget** displaying "Rate: `<Movie Name>`" with font size 24 and bold
2. **Three rows for the three metrics**, each row contains:
   - Text label for the metric name (e.g., "Plot:")
   - Row of 5 star IconButtons to select rating (1-5 stars)
   ```
   Plot:           ☆ ☆ ☆ ☆ ☆
   Characters:     ☆ ☆ ☆ ☆ ☆
   Cinematography: ☆ ☆ ☆ ☆ ☆
   ```
3. An **OutlinedButton** with text "Clear Rating"
   - Resets all 3 metrics to 0 stars (unselected)
   - Displays **SnackBar** with message "Ratings cleared"
4. A **FilledButton** with text "Submit Rating"

**Star IconButton behavior:**
- Unselected: `Icon(Icons.star_border, color: Colors.grey)`
- Selected: `Icon(Icons.star, color: Colors.amber)`
- Clicking a star fills all stars from left up to and including that star
  - Example: Click 3rd star → ★★★☆☆ (3 stars selected)
  - Example: Click 5th star → ★★★★★ (5 stars selected)

**Validation when Submit Rating is clicked:**
- If **any metric has 0 stars** selected (not rated):
  - Display **SnackBar** with message "Please rate all metrics"
  - Do NOT navigate back
- If **all 3 metrics are rated** (each has 1-5 stars):
  - Calculate average rating: `(plot + characters + cinematography) / 3`
  - Display **Text widget** below button showing "Movie Average: X.XX ★"
  - Display **SnackBar** with message "Rating submitted! Average: X.XX stars"
  - Navigate back to Screen 1 using `Navigator.pop()` after 1 second
  - Screen 1 should show the updated rating in the ListView
