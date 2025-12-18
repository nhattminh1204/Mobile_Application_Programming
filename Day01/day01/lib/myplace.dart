import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: myBody());
  }

  Widget myBody() {
    return Column(children: [block1(), block2(), block3(), block4()]);
  }

  Widget block1() {
    var src =
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/6d/f5/df/oeschinen-lake.jpg?w=900&h=500&s=1";
    return Image.network(src);
  }

  Widget block2() {
    var namePlace = "Oeschinen Lake Campground";
    var address = "Kandersteg, Switzerland";
    var vote = "41";
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                namePlace,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text(address),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.red),
              Text(vote, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget block3() {
    var color = Colors.blue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.call, color: color),
              Text("Call"),
            ],
          ),
          Column(
            children: [
              Icon(Icons.directions, color: color),
              Text("Route"),
            ],
          ),
          Column(
            children: [
              Icon(Icons.share, color: color),
              Text("Share"),
            ],
          ),
        ],
      ),
    );
  }

  Widget block4() {
    var data =
        "Hồ Oeschinen (Oeschinensee) là một viên ngọc thiên nhiên tuyệt đẹp nằm tại vùng Bernese Oberland, Thụy Sĩ, gần làng Kandersteg, được UNESCO công nhận là Di sản Thiên nhiên Thế giới thuộc khu vực Jungfrau–Aletsch. Nằm ở độ cao 1.578 mét so với mực nước biển, hồ có diện tích khoảng 1,115 km² và độ sâu tối đa 56 mét, hình thành từ các vụ sạt lở đá tiền sử tạo nên con đập tự nhiên giữa Kandersteg và Kandergrund. Nổi bật với màu nước xanh ngọc do các hạt bột băng lơ lửng trong nước, hồ được bao quanh bởi các đỉnh núi hùng vĩ như Bluemlisalp, Oeschinenhorn, Fründenhorn và Doldenhorn, tạo nên khung cảnh ngoạn mục. Du khách có thể tham gia nhiều hoạt động thú vị như chèo thuyền, đi bộ đường dài, trượt tuyết mùa đông hay thưởng thức các quán cà phê ven hồ. Hành trình đến hồ có thể đi bằng cáp treo từ Kandersteg và đi bộ khoảng 30 phút hoặc đi bộ thẳng từ làng với con đường dốc thử thách. Đây là điểm đến lý tưởng cho những ai yêu thiên nhiên, muốn trải nghiệm cảnh sắc tuyệt đẹp và lưu lại những kỷ niệm khó quên tại Thụy Sĩ.";
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Text(data, textAlign: TextAlign.justify),
    );
  }
}
