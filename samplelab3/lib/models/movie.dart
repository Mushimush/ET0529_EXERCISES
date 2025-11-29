// A Model class is a blueprint for organizing data
// It groups related data together and provides methods to work with that data
class Movie {
  // These are class properties (also called fields) - variables that belong to each Movie object
  String name;
  // int? means this can be either an integer OR null
  // The ? makes it "nullable" - we use null to represent "not yet rated"
  int? plotRating;         // null if not rated, 1-5 if rated
  int? charactersRating;   // null if not rated, 1-5 if rated
  int? cinematographyRating; // null if not rated, 1-5 if rated

  // This is a constructor - it creates a new Movie object
  // Movie(this.name) is shorthand for: Movie(String name) { this.name = name; }
  // It automatically assigns the parameter to the class property
  Movie(this.name);

  // A method is a function that belongs to a class
  // bool means this returns true or false
  bool isRated() {
    // && is the logical AND operator - ALL conditions must be true for the result to be true
    // We check if all three ratings are NOT null (meaning they have been set)
    return plotRating != null &&
           charactersRating != null &&
           cinematographyRating != null;
  }

  // double? means this returns either a decimal number OR null
  // Returns null if the movie hasn't been fully rated yet
  double? getAverage() {
    // If not all ratings are set, return null (can't calculate average)
    if (!isRated()) return null;
    // The ! is the null assertion operator - it tells Dart "I promise this is not null"
    // We can safely use ! here because isRated() already confirmed they're not null
    return (plotRating! + charactersRating! + cinematographyRating!) / 3;
  }
}
