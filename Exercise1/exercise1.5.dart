// Exercise 1.5 - Art class

class Art {
  String title;
  String? name;
  String? medium;
  int? year;

  // Constructor with named parameters where title is required
  Art({
    required this.title,
    this.name,
    this.medium,
    this.year,
  });

  // Method to display art information
  void displayInfo() {
    print('The art piece is $title');
    print('The artist is ${name ?? 'unknown!'}');
    print('The year is ${year ?? 'unknown!'}');
    print('The medium is ${medium ?? 'unknown!'}');
  }
}

// Test code
void main() {
  // Create an Art object with some null values
  Art art1 = Art(
    title: 'Woman with a Parasol',
    year: 1875,
  );

  // Display the art information
  art1.displayInfo();
  
  print('\n---\n');
  
  // Create another Art object with all values provided
  Art art2 = Art(
    title: 'Mona Lisa',
    name: 'Leonardo da Vinci',
    medium: 'oil on canvas',
    year: 1517,
  );
  
  art2.displayInfo();
}