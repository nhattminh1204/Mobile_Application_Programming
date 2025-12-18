import 'package:flutter/material.dart';

class Calculate_BMI extends StatefulWidget {
  const Calculate_BMI({super.key});

  @override
  State<Calculate_BMI> createState() => _Calculate_BMIState();
}

class _Calculate_BMIState extends State<Calculate_BMI> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmiResult;

  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đúng chiều cao và cân nặng!")),
      );
      return;
    }

    // Công thức BMI = kg / (m*m)
    double heightInMeter = height / 100;
    double bmi = weight / (heightInMeter * heightInMeter);

    setState(() {
      _bmiResult = bmi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: 450,
              child: TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Height (cm)",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 450,
              child: TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight (kg)",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text("Calculate BMI"),
            ),
            SizedBox(height: 20),
            Text(
              _bmiResult == null
                  ? "Your BMI will appear here"
                  : "Your BMI is: ${_bmiResult!.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
