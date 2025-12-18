import 'package:flutter/material.dart';

class CountNumber extends StatefulWidget {
  CountNumber({super.key});

  @override
  State<CountNumber> createState() => _CountNumberState();
}

class _CountNumberState extends State<CountNumber> {
  int count_number = 0;

  void _reduce() {
    setState(() {
      count_number--;
    });
  }

  void _reset() {
    setState(() {
      count_number = 0;
    });
  }

  void _increase() {
    setState(() {
      count_number++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.numbers),
        title: Text(
          "Count Number Application",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Container(
        color: const Color.fromARGB(255, 229, 229, 229),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Present Value:",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),

            SizedBox(height: 20),

            Text(
              count_number.toString(),
              style: TextStyle(
                color: const Color.fromARGB(255, 194, 37, 26),
                fontSize: 80,
                fontWeight: FontWeight.w900,
              ),
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _reduce,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      255,
                      245,
                      84,
                      73,
                    ), // màu nền
                    foregroundColor: Colors.white, // màu chữ
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text("Reduce"),
                ),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: _increase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 76, 204, 80),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text("Increase"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
