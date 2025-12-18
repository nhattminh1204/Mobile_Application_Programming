import 'package:flutter/material.dart';

class HomestayApp extends StatelessWidget {
  const HomestayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Column(
              children: [
                // Header xanh
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.blue.shade600,
                ),
                // Navbar với các button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavButton(Icons.sort, 'Sắp xếp'),
                      _buildNavButton(Icons.filter_list, 'Lọc'),
                      _buildNavButton(Icons.map, 'Bản đồ'),
                    ],
                  ),
                ),
                // Nội dung homestay
                const Expanded(child: HomestayListView()),
              ],
            ),
            // Search box với header bên trong
            Positioned(
              top: 24,
              left: 10,
              right: 10,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.amber, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Xung quanh vị trí hiện tại',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '23 thg 10 - 24 thg 10',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label) {
    return Row(
      children: [Icon(icon, size: 20), const SizedBox(width: 4), Text(label)],
    );
  }
}

class HomestayListView extends StatelessWidget {
  const HomestayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('757 chỗ nghỉ', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 16),
          const HomestayCard(
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAbGaNA8XWKiRIErCfyxpGresw_o7B4Hr1kS7zmg5AS9y6dryY8qQa_um3sS_oGwbo1w0&usqp=CAU',
            title: 'aNhill Boutique',
            rating: 9.5,
            reviewText: 'Xuất sắc',
            reviewsCount: 95,
            location: 'Huế - Cách bạn 0,6 km',
            roomType: '1 suite riêng tư',
            bedInfo: '1 giường',
            price: 109,
            cardType: 1,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 16),
          const HomestayCard(
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfZJtepCQjJ6-fK8n0wW_dTmhKTsxAFenJCTJemzFwyPUfCmo_CiRUOIZbK9lY9jy9_mM&usqp=CAU',
            title: 'Sun Homestay',
            rating: 9.2,
            reviewText: 'Tuyệt hảo',
            reviewsCount: 34,
            location: 'Cư Chính - Cách bạn 0,9 km',
            roomType: '1 phòng khách sạn',
            bedInfo: '1 giường',
            price: 20,
            cardType: 2,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 16),
          const HomestayCard(
            imageUrl:
                'https://media.istockphoto.com/id/1442290550/photo/pedestrians-in-the-shibuya-ward-of-tokyo-japan.jpg?s=612x612&w=0&k=20&c=7lbT2Dh-6vaI7ijNvsf9WN-enRCXoNb4iSMLRxOIxXI=',
            title: 'Huế Jade Hill Villa',
            rating: 8.0,
            reviewText: 'Rất tốt',
            reviewsCount: 12,
            location: 'Cư Chính - Cách bạn 1,3 km',
            roomType: '1 biệt thự nguyên căn - 1.000 m²',
            bedInfo: '4 giường • 3 phòng ngủ • 3 phòng tắm',
            price: 285,
            cardType: 3,
          ),
        ],
      ),
    );
  }
}

class HomestayCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final String reviewText;
  final int reviewsCount;
  final String location;
  final String roomType;
  final String bedInfo;
  final double price;
  final int cardType;

  const HomestayCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.reviewText,
    required this.reviewsCount,
    required this.location,
    required this.roomType,
    required this.bedInfo,
    required this.price,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // === ẢNH HOMESTAY (CỐ ĐỊNH CHIỀU NGANG) ===
        SizedBox(
          width: 150,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 150,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // Ô "Bao bữa sáng"
              if (cardType == 1 || cardType == 2)
                Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 76, 178, 80),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Bao bữa sáng",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // === THÔNG TIN HOMESTAY ===
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hàng 1
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cột trái
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (cardType == 1)
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                            ),
                          )
                        else if (cardType == 3)
                          const Text(
                            'Được quản lý bởi một host cá nhân',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                              child: Text(
                                rating == 8.0 ? '8,0' : rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$reviewText • $reviewsCount đánh giá',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                location,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Icon tim
                  const Icon(Icons.favorite_border),
                ],
              ),

              const SizedBox(height: 12),

              // Hàng 2 (Căn phải, nằm dưới)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: '$roomType:\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: bedInfo),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'US\$$price',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const Text(
                          'Đã bao gồm thuế và phí',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        if (cardType == 3) ...<Widget>[
                          const SizedBox(height: 4),
                          const Text(
                            'Chỉ còn 1 căn với giá này trên Booking.com',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            '✓ Không cần thanh toán trước',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
