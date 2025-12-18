import 'package:flutter/material.dart';

class MyClassroom extends StatelessWidget {
  const MyClassroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1A1D1F)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: myBody(context)
    );
  }

  Widget myBody(BuildContext context) {
    // Đưa myBody vào SafeArea để tránh bị che bởi thanh trạng thái
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              children: List.generate(10, (index) => item(index)),
            ),
          ),
          // Navigation Controls
          // Navigation Controls removed
        ],
      ),
    );
  }

  Widget item(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/seed/${index + 1}/400/200'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6), 
              BlendMode.darken
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "2025-2026.1.TIN4583.001",
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text("58 học viên", style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
