import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cái cây
    return Scaffold(body: myBody());
  }

  Widget myBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Flutter Core",
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.heart_broken, size: 100, color: Colors.red),
          Text(
            "Lập trình ứng dụng cho các thiết bị di động",
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
