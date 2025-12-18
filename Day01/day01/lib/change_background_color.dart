import 'dart:math';

import 'package:flutter/material.dart';

class ChangeBackgroundColor extends StatefulWidget {
  ChangeBackgroundColor({super.key});

  @override
  State<ChangeBackgroundColor> createState() => _ChangeBackgroundColorState();
}

class _ChangeBackgroundColorState extends State<ChangeBackgroundColor> {
  Color bgColor = Colors.green;
  String bgColorStr = 'Green';
  Color txtColor = Colors.white;

  List<Color> lstColor = [
    Colors.green,
    Colors.red,
    Colors.pink,
    Colors.blue,
    Colors.orange,
  ];

  List<String> lstColorStr = ['Green', 'Red', 'Pink', 'Blue', 'Orange'];

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
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.color_lens),
        // Title
        title: Text(
          "Change Background Color",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Container(
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

            SizedBox(height: 50),

            Text(bgColorStr, style: TextStyle(color: txtColor, fontSize: 25)),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _changeColor,
                  child: Text("Change Color"),
                ),
                ElevatedButton(
                  onPressed: _defaultColor,
                  child: Text("Default Background"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
