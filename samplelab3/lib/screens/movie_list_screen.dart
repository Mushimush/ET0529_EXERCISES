import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'rate_movie_screen.dart';

// StatefulWidget is a widget that CAN change and rebuild during its lifetime
// Use StatefulWidget when the UI needs to update (e.g., after user interaction)
// StatefulWidget requires TWO classes: the Widget class and the State class
class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  // createState() creates and returns the State object that holds the mutable state
  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

// The State class contains the actual state (data) and the build method
class _MovieListScreenState extends State<MovieListScreen> {
  // final means this variable can't be reassigned to a different list
  // But we CAN still modify the contents of the list (add, remove, change items)
  // List<Movie> means this is a list that can only contain Movie objects
  final List<Movie> movies = [
    Movie('Inception'),
    Movie('Avatar'),
    Movie('Titanic'),
    Movie('Interstellar'),
    Movie('The Matrix'),
  ];


  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic page structure: appBar at top, body in middle, etc.
    return Scaffold(
      // AppBar is the top bar that typically shows the screen title
      appBar: AppBar(
        title: const Text('Movie Ratings by Your Name'),
        backgroundColor: Colors.blue,
      ),
      // Column arranges its children widgets vertically (top to bottom)
      body: Column(
        children: [
          // Padding adds empty space around its child widget
          // EdgeInsets.all(16.0) adds 16 pixels of padding on all sides
          Padding(
            padding: const EdgeInsets.all(16.0),
            // Image.asset loads an image from the assets folder defined in pubspec.yaml
            child: Image.asset(
              'assets/images/movies.png',
              height: 150,
            ),
          ),

          // =======================================================================
          // ListView.builder vs ListView - When to use which?
          // =======================================================================
          // ListView.builder: Use for DYNAMIC or LONG lists (items built on-demand)
          //   - More memory efficient for large lists
          //   - Items created only when scrolled into view
          //
          // ListView(children: [...]): Use for SMALL, FIXED lists
          //   - All items created upfront
          //   - Simpler syntax, good for 2-5 items
          //
          // ALTERNATIVE: Using ListView with children instead of ListView.builder:
          //   ListView(
          //     children: [
          //       ListTile(title: Text('Inception'), ...),
          //       ListTile(title: Text('Avatar'), ...),
          //       ListTile(title: Text('Titanic'), ...),
          //     ],
          //   )
          // We use ListView.builder here because we're building from a List variable (movies).
          // =======================================================================

          // Expanded takes up all remaining space in the Column
          // Without Expanded, ListView would cause an error because it has infinite height
          Expanded(
            child: ListView.builder(
              // itemCount tells the ListView how many items to build
              itemCount: movies.length,
              // itemBuilder is called for each item to create its widget
              // context is the build context, index is the position (0, 1, 2, etc.)
              itemBuilder: (context, index) {
                // Get the movie at this index
                final movie = movies[index];
                // ListTile is a standard Material Design list item with predefined layout
                return ListTile(
                  // leading is the widget at the start (left side) of the ListTile
                  leading: const Icon(Icons.movie),
                  // title is the main text of the ListTile
                  title: Text(movie.name),
                  // subtitle is smaller text below the title
                  // The ternary operator (? :) chooses between two values based on a condition
                  // condition ? valueIfTrue : valueIfFalse
                  subtitle: Text(
                    movie.isRated()
                        ? 'Average: ${movie.getAverage()!.toStringAsFixed(2)} ★'
                        : 'Not rated yet',
                  ),
                  // onTap is called when user taps anywhere on the ListTile
                  onTap: () async {
                    // await pauses execution until Navigator.push completes (user comes back)
                    // Navigator.push adds a new screen on top of the current one
                    await Navigator.push(
                      context,
                      // MaterialPageRoute creates a platform-appropriate page transition
                      MaterialPageRoute(
                        // builder is a function that creates the destination screen
                        // We pass the movie object to RateMovieScreen via its constructor
                        // This is how we pass data from one screen to another!
                        builder: (context) => RateMovieScreen(movie: movie),
                      ),
                    );
                    // This code runs AFTER the user returns from RateMovieScreen
                    // setState tells Flutter to rebuild this widget with updated data
                    // The empty {} means we're not changing any variables, just triggering a rebuild
                    // This refreshes the list to show the new rating
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
