void main() {
  // Create map for artworks
  var artworks = <String, String>{
    'Mona Lisa': 'Leonardo da Vinci',
    'Woman with a Parasol': 'Claude Monet',
    'Sunflowers': 'Vincent van Gogh'
  };
  
  // c. Verify elements stored
  print('Artworks map: $artworks');
  
  // d. Check if 'Water Lilies' exists
  
  // Method 1: containsKey() is the cleanest & correct way to do it but it is not mentioned in the slides.
  bool hasWaterLilies = artworks.containsKey('Water Lilies');
  print('Contains "Water Lilies": $hasWaterLilies');
  
  // Method 2 (more cumbersome): using for loop to check each key
  bool exists = false;
  for (final title in artworks.keys) {
    if (title == 'Water Lilies') {
      exists = true;
      break;
    }
  }
  print('Contains "Water Lilies": $exists');
}