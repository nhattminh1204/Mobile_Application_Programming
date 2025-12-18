import 'package:flutter/material.dart';

class GuildToLayout extends StatelessWidget {
  const GuildToLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _MyBody());
  }
}

// Widget cơ bản chứa toàn bộ nội dung
class _MyBody extends StatelessWidget {
  const _MyBody();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Block1(),
            _Block2(), // Khoảng cách
            _Block3(), // Chào mừng
            _Block2(), // Khoảng cách
            _Block4(), // Thanh tìm kiếm
            _Block2(), // Khoảng cách
            _Block5(), // Tiêu đề Saved Places
            _WidgetPlaces(), // Sử dụng Column/Row thay GridView (2x2)
          ],
        ),
      ),
    );
  }
}

// Block 1: Icons ở góc trên bên phải
class _Block1 extends StatelessWidget {
  const _Block1();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.notifications),
          iconSize: 25,
        ),
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.extension),
          iconSize: 25,
        ),
      ],
    );
  }
}

// Block 2: Khoảng cách dọc (Spacing)
class _Block2 extends StatelessWidget {
  const _Block2();
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 40);
  }
}

// Block 3: Chữ "Welcome, Charlie"
class _Block3 extends StatelessWidget {
  const _Block3();
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Welcome,\n',
            style: TextStyle(
              color: Colors.black,
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Charlie',
            style: TextStyle(color: Colors.black, fontSize: 80),
          ),
        ],
      ),
    );
  }
}

// Block 4: Thanh tìm kiếm (Search Field)
class _Block4 extends StatelessWidget {
  const _Block4();
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        prefixIcon: Icon(Icons.search, color: Colors.blue),
        hintText: "Search",
      ),
    );
  }
}

// Block 5: Tiêu đề "Saved Places"
class _Block5 extends StatelessWidget {
  const _Block5();
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      child: Text(
        "Saved Places",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// WidgetPlaces: Hiển thị 2x2 bằng Column và Row (thay thế GridView)
class _WidgetPlaces extends StatelessWidget {
  const _WidgetPlaces();

  // Hàm xây dựng widget hiển thị một ảnh
  Widget _buildImageContainer(String url) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0, // Đảm bảo hình vuông
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            // Fallback khi ảnh lỗi hoặc đang tải
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = const [
      'https://bizweb.dktcdn.net/100/562/154/files/vuong-quoc-anh-18-jpg.jpg?v=1755593157560',
      'https://bizweb.dktcdn.net/100/562/154/files/vuong-quoc-anh-11-jpg.jpg?v=1755593157500',
      'https://bizweb.dktcdn.net/100/562/154/files/vuong-quoc-anh-7-jpg.jpg?v=1755593157473',
      'https://bizweb.dktcdn.net/100/562/154/files/vuong-quoc-anh-22-jpg.jpg?v=1755593157473',
    ];

    const double spacing = 10;

    // Sử dụng Column và Row để tạo bố cục 2x2
    return Column(
      children: [
        // Hàng 1: Hai ảnh đầu tiên
        Row(
          children: [
            _buildImageContainer(images[0]),
            const SizedBox(width: spacing), // Khoảng cách ngang giữa các ảnh
            _buildImageContainer(images[1]),
          ],
        ),

        const SizedBox(height: spacing), // Khoảng cách dọc giữa hai hàng
        // Hàng 2: Hai ảnh cuối cùng
        Row(
          children: [
            _buildImageContainer(images[2]),
            const SizedBox(width: spacing), // Khoảng cách ngang giữa các ảnh
            _buildImageContainer(images[3]),
          ],
        ),
      ],
    );
  }
}
