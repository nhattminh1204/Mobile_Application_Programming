import 'package:flutter/material.dart';

class MyClassroom extends StatelessWidget {
  const MyClassroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: myBody());
  }

  Widget myBody() {
    var tenHocPhan;
    var maHocPhan;
    var soHocVien;
    // Đưa myBody vào SafeArea để tránh bị che bởi thanh trạng thái
    return SafeArea(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(10, (index) => item()),
      ),
    );
  }

  Widget item() {
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 80, 77, 77),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "XML và ứng dụng - Nhóm 1",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "2025-2026.1.TIN4583.001",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Text("58 học viên", style: TextStyle(color: Colors.white)),
            ],
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.more_horiz, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
