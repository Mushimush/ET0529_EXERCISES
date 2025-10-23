void main() {
  // Test cases
  print(compareStrings(str1: 'mobile', str2: 'MOBILE')); // true
  print(compareStrings(str1: 'Mobile', str2: 'mobile')); // true
  print(compareStrings(str1: 'phone', str2: 'tablet')); // false
}

bool compareStrings({required String str1, required String str2}) {
  return str1.toLowerCase() == str2.toLowerCase();
}