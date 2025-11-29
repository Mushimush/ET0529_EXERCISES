import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// StatefulWidget is a widget that CAN change and rebuild during its lifetime
// Use StatefulWidget when the UI needs to update (e.g., after user interaction)
class VoucherCheckPage extends StatefulWidget {
  const VoucherCheckPage({super.key});

  // createState() creates and returns the State object that holds the mutable state
  @override
  State<VoucherCheckPage> createState() => _VoucherCheckPageState();
}

// The State class contains the actual state (data) and the build method
class _VoucherCheckPageState extends State<VoucherCheckPage> {
  // TextEditingController manages the text being edited in a TextField
  // final means this variable can't be reassigned, but the controller's content can change
  final TextEditingController _expenditureController = TextEditingController();

  // State variables - these hold data that can change and trigger UI rebuilds
  int _numVouchers = 0; // Number of vouchers earned
  bool _isSpecialVoucher = false; // Whether user qualifies for special voucher
  bool _hasChecked = false; // Whether user has clicked the check button

  // Method to calculate vouchers based on expenditure
  void _checkVouchers() {
    // setState tells Flutter to rebuild the UI with new values
    setState(() {
      // double.tryParse converts String to double, returns null if invalid
      // ?? 0 means "if null, use 0 instead" (null coalescing operator)
      double expenditure = double.tryParse(_expenditureController.text) ?? 0;

      // Calculate number of vouchers (every $200 = 1 voucher, max 8)
      if (expenditure < 200) {
        _numVouchers = 0;
      } else if (expenditure >= 1600) {
        _numVouchers = 8; // Maximum 8 vouchers
      } else {
        // ~/ is integer division (divides and rounds down)
        // Example: 500 ~/ 200 = 2 vouchers
        _numVouchers = (expenditure ~/ 200);
      }

      // Check if special voucher (expenditure >= $1200)
      _isSpecialVoucher = expenditure >= 1200;
      _hasChecked = true; // Mark that user has checked
    });
  }

  // Helper method that builds the voucher display widget
  // Returns a Widget, so it can be used inside the build method
  Widget _buildVoucherDisplay() {
    // If user hasn't checked yet, return an empty widget
    // SizedBox.shrink() creates an invisible zero-size widget
    if (!_hasChecked) {
      return const SizedBox.shrink();
    }

    // If no vouchers earned, just show text
    if (_numVouchers == 0) {
      return const Text(
        'Number of vouchers: 0',
        style: TextStyle(fontSize: 16),
      );
    }

    // Build a list of widgets for the Row
    List<Widget> rowChildren = [];

    // Add the label text first
    rowChildren.add(const Text(
      'Number of vouchers: ',
      style: TextStyle(fontSize: 16),
    ));

    // Use a for loop to add voucher icons
    // This is an alternative to List.generate
    for (int i = 0; i < _numVouchers; i++) {
      // Ternary operator: condition ? valueIfTrue : valueIfFalse
      // If special voucher, show star icon; otherwise show box icon
      rowChildren.add(Icon(_isSpecialVoucher ? Icons.star_purple500_rounded : Icons.add_box));
      // Add spacing between icons (but not after the last one)
      if (i < _numVouchers - 1) {
        rowChildren.add(const SizedBox(width: 4));
      }
    }

    return Column(
      children: [
        Row(
          // Center the icons horizontally
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
      ],
    );
  }

  // dispose() is called when this widget is removed from the widget tree
  // Use it to clean up resources like controllers to prevent memory leaks
  @override
  void dispose() {
    // Always dispose controllers when done
    _expenditureController.dispose();
    // Call parent's dispose last
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic page structure: appBar at top, body in middle
    return Scaffold(
      appBar: AppBar(
        // Theme.of(context) accesses the app's theme data
        // colorScheme.inversePrimary is a color that contrasts with the primary color
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lab Test 1 Sample by <your name>'),
      ),
      body: Padding(
        // EdgeInsets.all(16.0) adds 16 pixels of padding on all sides
        padding: const EdgeInsets.all(16.0),
        // Column arranges its children vertically (top to bottom)
        child: Column(
          // crossAxisAlignment controls horizontal alignment in a Column
          // CrossAxisAlignment.center centers children horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. The image "gift.png"
            // Image.asset loads an image from the assets folder defined in pubspec.yaml
            Image.asset(
              'assets/images/gift.png',
              width: 200,
              height: 200,
            ),
            // SizedBox with height creates vertical spacing
            const SizedBox(height: 20),

            // 2. Text "Enter expenditure: $" followed by TextField
            // Row arranges its children horizontally (left to right)
            Row(
              // mainAxisAlignment controls alignment along the main axis (horizontal for Row)
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  // \$ escapes the dollar sign in the string
                  'Enter expenditure: \$',
                  style: TextStyle(fontSize: 16),
                ),
                // SizedBox with width constrains the TextField's width
                SizedBox(
                  width: 150,
                  child: TextField(
                    // controller connects this TextField to our TextEditingController
                    controller: _expenditureController,
                    // keyboardType.number shows a numeric keyboard on mobile
                    keyboardType: TextInputType.number,
                    // inputFormatters restrict what characters can be entered
                    inputFormatters: [
                      // Only allow digits 0-9 and decimal point
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    decoration: const InputDecoration(
                      // OutlineInputBorder adds a border around the TextField
                      border: OutlineInputBorder(),
                      // isDense reduces the height of the TextField
                      isDense: true,
                      // contentPadding controls padding inside the TextField
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 3. FilledButton with text "check"
            // FilledButton has a solid background color
            FilledButton(
              // onPressed is called when the button is tapped
              // We pass the method reference (no parentheses)
              onPressed: _checkVouchers,
              child: const Text('check'),
            ),
            const SizedBox(height: 20),

            // 4. Output area - calls our helper method
            _buildVoucherDisplay(),
          ],
        ),
      ),
    );
  }
}
