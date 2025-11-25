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
