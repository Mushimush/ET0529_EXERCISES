// =============================================================================
// Art Model Class
// =============================================================================
// This is a simple data model (also called POJO - Plain Old Java Object,
// or in Dart terms, a plain Dart class) that represents a single art piece.
//
// PURPOSE: To define the structure/blueprint of an Art object with its properties.
// This class does NOT use 'static' because each art piece needs its own
// unique values (instance-specific data).
// =============================================================================

class Art {
  // Instance variables - each Art object has its own copy of these
  // These are NOT static because every art piece has different values
  String artId = "";    // Unique identifier for the art piece
  String title = "";    // Name/title of the artwork
  String artist = "";   // Name of the artist who created it
  String image = "";    // Filename of the image (e.g., "sunflowers.png")

  // Constructor - creates a new Art object with the provided values
  // 'this.artId' is shorthand for: this.artId = artId
  // This automatically assigns the parameter values to the instance variables
  Art(this.artId, this.title, this.artist, this.image);
}
