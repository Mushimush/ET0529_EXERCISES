import 'package:flutter/material.dart';
import 'voucher_check_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Test 1 Sample',
      home: const VoucherCheckPage(),
    );
  }
}
