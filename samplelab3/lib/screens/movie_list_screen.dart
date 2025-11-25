import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'rate_movie_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  // Initialize list of 5 movies
  final List<Movie> movies = [
    Movie('Inception'),
    Movie('Avatar'),
    Movie('Titanic'),
    Movie('Interstellar'),
    Movie('The Matrix'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Ratings by Your Name'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Image at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/movies.png',
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.movie, size: 80, color: Colors.grey),
                  ),
                );
              },
            ),
          ),

          // ListView with movies
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: const Icon(Icons.movie),
                  title: Text(movie.name),
                  subtitle: Text(
                    movie.isRated()
                        ? 'Average: ${movie.getAverage()!.toStringAsFixed(2)} ★'
                        : 'Not rated yet',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () async {
                      // Navigate to rating screen and wait for result
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RateMovieScreen(movie: movie),
                        ),
                      );
                      // Refresh the screen after returning
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
