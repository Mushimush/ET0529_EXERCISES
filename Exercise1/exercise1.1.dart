void main() {
  var a = ['Betty', 30, 50, 'Allan'];
  
  // add code below to generate the output
  for (var item in a) {
    if (item is String) {
      print('$item is a string');
    } else if (item is num) {
      print('$item is a number');
    }
  }
}