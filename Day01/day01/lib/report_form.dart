import 'package:flutter/material.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _report = TextEditingController();

  int? _selectedStars;

  void _sendReport() {
    if (_fullName.text.isEmpty ||
        _report.text.isEmpty ||
        _selectedStars == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập đầy đủ thông tin và chọn số sao!"),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Cảm ơn bạn!"),
          content: Text(
            "Cảm ơn ${_fullName.text} đã đánh giá "
            "${_selectedStars} sao với nội dung:\n\n"
            "${_report.text}",
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                _fullName.clear();
                _report.clear();
                setState(() => _selectedStars = null);
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

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
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     const Text(
                      "Gửi phản hồi",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xFF1A1D1F)),
                    ),
                    const SizedBox(height: 20),
                    // Họ tên
                    TextField(
                      controller: _fullName,
                      decoration: const InputDecoration(
                        labelText: "Họ tên",
                        prefixIcon: Icon(Icons.person, color: Color(0xFF1A1D1F)),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1A1D1F), width: 2.0),
                        ),
                      ),
                    ),
              
                    const SizedBox(height: 20),
              
                    // Dropdown chọn sao
                    DropdownButtonFormField<int>(
                      value: _selectedStars,
                      decoration: const InputDecoration(
                        labelText: "Đánh giá (1–5 sao)",
                        prefixIcon: Icon(
                          Icons.star_rate,
                          color: Color(0xFF1A1D1F),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1A1D1F), width: 2.0),
                        ),
                      ),
                      items: [1, 2, 3, 4, 5].map((value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text("$value sao"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedStars = value);
                      },
                    ),
              
                    const SizedBox(height: 20),
              
                    // Nội dung góp ý
                    TextField(
                      controller: _report,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: "Nội dung góp ý",
                        prefixIcon: Icon(
                          Icons.feedback,
                          color: Color(0xFF1A1D1F),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1A1D1F), width: 2.0),
                        ),
                      ),
                    ),
              
                    const SizedBox(height: 20),
              
                    // Nút gửi
                    ElevatedButton.icon(
                      onPressed: _sendReport,
                      icon: const Icon(Icons.send),
                      label: const Text("Gửi phản hồi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1D1F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
             // Navigation Controls
            // Navigation Controls removed
          ],
        ),
      ),
    );
  }
}
