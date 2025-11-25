import 'package:flutter/material.dart';
import '../models/movie.dart';

class RateMovieScreen extends StatefulWidget {
  final Movie movie;

  const RateMovieScreen({super.key, required this.movie});

  @override
  State<RateMovieScreen> createState() => _RateMovieScreenState();
}

class _RateMovieScreenState extends State<RateMovieScreen> {
  int plotRating = 0;
  int charactersRating = 0;
  int cinematographyRating = 0;
  double? calculatedAverage;

  @override
  void initState() {
    super.initState();

    // Load existing ratings if available
    if (widget.movie.plotRating != null) {
      plotRating = widget.movie.plotRating!;
      charactersRating = widget.movie.charactersRating!;
      cinematographyRating = widget.movie.cinematographyRating!;
      // Also show the average if already rated
      calculatedAverage = widget.movie.getAverage();
    }
  }

  // Build a row of star buttons for a metric
  Widget buildStarRow(String label, int currentRating, Function(int) onRatingChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ...List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < currentRating ? Icons.star : Icons.star_border,
                color: index < currentRating ? Colors.amber : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  onRatingChanged(index + 1);
                  calculatedAverage = null; // Reset average when rating changes
                });
              },
            );
          }),
        ],
      ),
    );
  }

  void clearRating() {
    setState(() {
      plotRating = 0;
      charactersRating = 0;
      cinematographyRating = 0;
      calculatedAverage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ratings cleared'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void submitRating() {
    // Validate: check if all metrics are rated
    if (plotRating == 0 || charactersRating == 0 || cinematographyRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please rate all metrics'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Calculate average
    double average = (plotRating + charactersRating + cinematographyRating) / 3;

    // Update movie ratings
    widget.movie.plotRating = plotRating;
    widget.movie.charactersRating = charactersRating;
    widget.movie.cinematographyRating = cinematographyRating;

    setState(() {
      calculatedAverage = average;
    });

    // Show success SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rating submitted! Average: ${average.toStringAsFixed(2)} stars'),
        duration: const Duration(seconds: 1),
      ),
    );

    // Navigate back after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.name),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie name header
              Text(
                'Rate: ${widget.movie.name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Plot rating
              buildStarRow('Plot', plotRating, (rating) {
                plotRating = rating;
              }),

              // Characters rating
              buildStarRow('Characters', charactersRating, (rating) {
                charactersRating = rating;
              }),

              // Cinematography rating
              buildStarRow('Cinematography', cinematographyRating, (rating) {
                cinematographyRating = rating;
              }),

              const SizedBox(height: 32),

              // Buttons row
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Clear Rating button
                    OutlinedButton(
                      onPressed: clearRating,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        child: Text('Clear Rating', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Submit button
                    FilledButton(
                      onPressed: submitRating,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        child: Text('Submit Rating', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Display average if calculated
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
