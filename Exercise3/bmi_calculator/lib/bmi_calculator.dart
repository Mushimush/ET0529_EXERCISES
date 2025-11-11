import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _bmiResult = '';

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
      const SnackBar snackBar = SnackBar(
        content: Text('Please enter both height and weight'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      final double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        _bmiResult = 'Your BMI is ${bmi.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _bmiResult = 'Please enter valid height and weight';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
                hintText: 'Enter your height in centimeters',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
                hintText: 'Enter your weight in kilograms',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _calculateBMI, child: Text('Calculate')),
            const SizedBox(height: 24),
            Text(_bmiResult, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
