import 'package:flutter/material.dart';
import '../homestay.dart';

class HomestayContent extends StatelessWidget {
  const HomestayContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.blue.shade600,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
              const Expanded(child: HomestayListView()),
            ],
          ),
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
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(Icons.search, color: Colors.black),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Xung quanh vị trí hiện tại • 23 thg 10 - 24 thg 10',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label) {
    return Row(
      children: [Icon(icon, size: 20), const SizedBox(width: 4), Text(label)],
    );
  }
}