import 'dart:math';
import 'package:flutter/material.dart';

class ChangeBackgroundColorContent extends StatefulWidget {
  const ChangeBackgroundColorContent({Key? key}) : super(key: key);

  @override
  State<ChangeBackgroundColorContent> createState() => _ChangeBackgroundColorContentState();
}

class _ChangeBackgroundColorContentState extends State<ChangeBackgroundColorContent> {
  Color bgColor = Colors.green;
  String bgColorStr = 'Green';
  Color txtColor = Colors.white;

  final List<Color> lstColor = [
    Colors.green,
    Colors.red,
    Colors.pink,
    Colors.blue,
    Colors.orange,
  ];

  final List<String> lstColorStr = ['Green', 'Red', 'Pink', 'Blue', 'Orange'];

  void _changeColor() {
    setState(() {
      var random = Random();
      var r = random.nextInt(lstColor.length);
      bgColor = lstColor[r];
      bgColorStr = lstColorStr[r];
      txtColor = Colors.white;
    });
  }

  void _defaultColor() {
    setState(() {
      bgColor = Colors.white;
      txtColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Color Current',
            style: TextStyle(
              color: txtColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 50),
          Text(bgColorStr, style: TextStyle(color: txtColor, fontSize: 25)),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _changeColor,
                child: const Text("Change Color"),
              ),
              ElevatedButton(
                onPressed: _defaultColor,
                child: const Text("Default Background"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}