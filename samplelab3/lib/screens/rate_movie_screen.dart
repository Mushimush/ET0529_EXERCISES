import 'package:flutter/material.dart';
import '../models/movie.dart';

// This screen receives a Movie object from the previous screen (MovieListScreen)
class RateMovieScreen extends StatefulWidget {
  // final means this property can't be changed after it's set
  // This is the parameter that receives data from the previous screen
  final Movie movie;

  // required means this parameter MUST be provided when creating this widget
  // RateMovieScreen(movie: someMovie) - you can't create it without passing a movie
  const RateMovieScreen({super.key, required this.movie});

  @override
  State<RateMovieScreen> createState() => _RateMovieScreenState();
}

class _RateMovieScreenState extends State<RateMovieScreen> {
  // These are local state variables - they hold the current rating values
  // They start at 0 and change as the user taps stars
  int plotRating = 0;
  int charactersRating = 0;
  int cinematographyRating = 0;
  double? calculatedAverage; // null until user submits

  // initState is called ONCE when this widget is first created
  // Use it to initialize values or load data
  @override
  void initState() {
    // super.initState() must be called first - it runs the parent class's initState
    super.initState();

    // widget.movie is how the State class accesses properties from the Widget class
    // "widget" refers to the RateMovieScreen widget that created this state
    // Check if the movie already has ratings (user is editing, not rating for first time)
    if (widget.movie.plotRating != null) {
      // Load the existing ratings into our local state variables
      plotRating = widget.movie.plotRating!;
      charactersRating = widget.movie.charactersRating!;
      cinematographyRating = widget.movie.cinematographyRating!;
      // Also show the existing average
      calculatedAverage = widget.movie.getAverage();
    }
  }

  // This is a helper method that builds a row of star buttons
  // It returns a Widget, so it can be used inside the build method
  // Parameters:
  //   label: the text label (e.g., "Plot")
  //   currentRating: the current selected rating (0-5)
  //   onRatingChanged: a callback function that's called when user taps a star
  Widget buildStarRow(String label, int currentRating, Function(int) onRatingChanged) {
    return Padding(
      // symmetric means different padding for vertical vs horizontal
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      // Row arranges its children horizontally (left to right)
      child: Row(
        children: [
          // SizedBox with width creates a fixed-width container
          // This ensures all labels have the same width for alignment
          SizedBox(
            width: 140,
            child: Text(
              '$label:', // String interpolation: inserts the label value
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // ... is the spread operator - it inserts all items into the Row's children list (the parent list)
          // List.generate creates a list of 5 items (indices 0-4)
          ...List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                // If index < currentRating, show filled star; otherwise show outline
                // Example: if currentRating is 3, indices 0,1,2 get filled stars
                // Visual: currentRating = 3 → ★★★☆☆
                index < currentRating ? Icons.star : Icons.star_border,
                // Same logic for color: amber for filled, grey for outline
                color: index < currentRating ? Colors.amber : Colors.grey,
              ),
              // onPressed is called when the user taps this button
              onPressed: () {
                // setState tells Flutter to rebuild the UI with new values
                setState(() {
                  // Call the callback function with the new rating (index + 1 because index starts at 0)
                  onRatingChanged(index + 1);
                  // Reset the average when rating changes (user needs to submit again)
                  calculatedAverage = null;
                });
              },
            );
          }),
        ],
      ),
    );
  }

  // Method to clear all ratings
  void clearRating() {
    setState(() {
      // Reset all values to their initial state
      plotRating = 0;
      charactersRating = 0;
      cinematographyRating = 0;
      calculatedAverage = null;
    });

    // ScaffoldMessenger.of(context) finds the nearest Scaffold and shows a SnackBar
    // SnackBar is a brief message that appears at the bottom of the screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ratings cleared'),
        duration: Duration(seconds: 1), // How long the SnackBar is visible
      ),
    );
  }

  // Method to validate and submit the rating
  void submitRating() {
    // Validation: check if all ratings have been set (not still 0)
    if (plotRating == 0 || charactersRating == 0 || cinematographyRating == 0) {
      // Early return pattern: exit the function early if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please rate all metrics'),
          duration: Duration(seconds: 2),
        ),
      );
      return; // Exit the function - don't run the code below
    }

    // Save the ratings to the movie object
    // Since movie is passed by reference, these changes affect the original object
    // in MovieListScreen too - this is how we "send data back"
    widget.movie.plotRating = plotRating;
    widget.movie.charactersRating = charactersRating;
    widget.movie.cinematographyRating = cinematographyRating;

    // Use the model's getAverage() method to calculate the average
    double average = widget.movie.getAverage()!;

    // Update the UI to show the calculated average
    setState(() {
      calculatedAverage = average;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // toStringAsFixed(2) formats the number to 2 decimal places
        content: Text('Rating submitted! Average: ${average.toStringAsFixed(2)} stars'),
        duration: const Duration(seconds: 1),
      ),
    );

    // Navigator.pop removes this screen and goes back to the previous screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // widget.movie.name accesses the movie's name passed from the previous screen
        title: Text(widget.movie.name),
        backgroundColor: Colors.blue,
      ),
      // SingleChildScrollView makes its child scrollable if content is too tall for the screen
      // Without this, content might overflow on smaller screens
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // crossAxisAlignment: CrossAxisAlignment.start aligns children to the left
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header showing which movie we're rating
              Text(
                'Rate: ${widget.movie.name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24), // Empty space (24 pixels tall)

              // Build star rating rows using our helper method
              // The third parameter is a callback that updates the corresponding variable
              buildStarRow('Plot', plotRating, (rating) {
                plotRating = rating;
              }),

              buildStarRow('Characters', charactersRating, (rating) {
                charactersRating = rating;
              }),

              buildStarRow('Cinematography', cinematographyRating, (rating) {
                cinematographyRating = rating;
              }),

              const SizedBox(height: 32),

              // Center widget centers its child horizontally
              Center(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center centers items in the Row
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // OutlinedButton has just an outline, no filled background
                    OutlinedButton(
                      onPressed: clearRating, // Reference to the method (no parentheses)
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Clear Rating', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16), // Horizontal space between buttons
                    // FilledButton has a solid background color
                    FilledButton(
                      onPressed: submitRating,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Submit Rating', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Conditional rendering: this widget only appears if calculatedAverage is not null
              // In Dart, you can use "if" directly inside a list of children
              if (calculatedAverage != null)
                Center(
                  child: Text(
                    'Movie Average: ${calculatedAverage!.toStringAsFixed(2)} ★',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
