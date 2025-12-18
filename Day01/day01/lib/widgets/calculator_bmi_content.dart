import 'package:flutter/material.dart';

class CalculatorBMIContent extends StatefulWidget {
  const CalculatorBMIContent({Key? key}) : super(key: key);

  @override
  State<CalculatorBMIContent> createState() => _CalculatorBMIContentState();
}

class _CalculatorBMIContentState extends State<CalculatorBMIContent> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmiResult;

  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đúng chiều cao và cân nặng!")),
      );
      return;
    }

    double heightInMeter = height / 100;
    double bmi = weight / (heightInMeter * heightInMeter);

    setState(() {
      _bmiResult = bmi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 450,
            child: TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 450,
            child: TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateBMI,
            child: const Text("Calculate BMI"),
          ),
          const SizedBox(height: 20),
          Text(
            _bmiResult == null
                ? "Your BMI will appear here"
                : "Your BMI is: ${_bmiResult!.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 24, color: Colors.red),
          ),
        ],
      ),
    );
  }
}