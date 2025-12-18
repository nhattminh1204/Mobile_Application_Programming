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
      appBar: AppBar(
        title: const Text(
          "Gửi phản hồi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Họ tên
            TextField(
              controller: _fullName,
              decoration: const InputDecoration(
                labelText: "Họ tên",
                prefixIcon: Icon(Icons.person, color: Colors.deepOrangeAccent),
                border: OutlineInputBorder(),
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
                  color: Colors.deepOrangeAccent,
                ),
                border: OutlineInputBorder(),
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
                  color: Colors.deepOrangeAccent,
                ),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Nút gửi
            ElevatedButton.icon(
              onPressed: _sendReport,
              icon: const Icon(Icons.send),
              label: const Text("Gửi phản hồi"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
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
    );
  }
}
