void main() {
  //Create an empty list named artList to store strings, initially empty
  List<String> artList = [];
  
  // c. Add 2 strings using add() function
  artList.add('Woman with a Parasol');
  artList.add('Sunflowers');
  
  // d. Test code to verify strings are stored properly
  print('Testing artList contents:');
  print(artList[0]);  // Should print: Woman with a Parasol
  print(artList[1]);  // Should print: Sunflowers
  print(artList);     // Should print: [Woman with a Parasol, Sunflowers]
  
  // e. Print number of elements in required format
  print('The number of elements in the list: ${artList.length}');
}