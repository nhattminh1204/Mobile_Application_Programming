import 'package:flutter/material.dart';

class CountNumberContent extends StatefulWidget {
  const CountNumberContent({Key? key}) : super(key: key);

  @override
  State<CountNumberContent> createState() => _CountNumberContentState();
}

class _CountNumberContentState extends State<CountNumberContent> {
  int countNumber = 0;

  void _reduce() {
    setState(() {
      countNumber--;
    });
  }

  void _reset() {
    setState(() {
      countNumber = 0;
    });
  }

  void _increase() {
    setState(() {
      countNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 229, 229, 229),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Present Value:",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(
            countNumber.toString(),
            style: const TextStyle(
              color: Color.fromARGB(255, 194, 37, 26),
              fontSize: 80,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _reduce,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 245, 84, 73),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text("Reduce"),
              ),
              ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text("Reset"),
              ),
              ElevatedButton(
                onPressed: _increase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 204, 80),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text("Increase"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}