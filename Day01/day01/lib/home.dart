import 'package:flutter/material.dart';
import 'page_wrapper.dart';
import 'calculator_bmi.dart';
import 'change_background_color.dart';
import 'classroom.dart';
import 'count_number.dart';
import 'form_login.dart';
import 'form_register.dart';
import 'guildtolayout.dart';
import 'widgets/homestay_content.dart';
import 'widgets/calculator_bmi_content.dart';
import 'widgets/change_background_color_content.dart';
import 'widgets/count_number_content.dart';
import 'my_product.dart';
import 'myhomepage.dart';
import 'myplace.dart';
import 'news_api.dart';
import 'report_form.dart';
import 'timer.dart';
import 'package:day01/profile_page.dart'; // Add import
import 'screens/cart_screen.dart';
import 'screens/news-list.dart';
import 'screens/product_list_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const Map<String, List<DrawerItem>> _drawerCategories = {
    'Cơ Bản': [
      DrawerItem(
        'Calculator BMI',
        Icons.calculate,
        'Calculator BMI',
        CalculatorBMIContent.new,
      ),
      DrawerItem(
        'Đổi Màu Nền',
        Icons.color_lens,
        'Đổi Màu Nền',
        ChangeBackgroundColorContent.new,
      ),
      DrawerItem(
        'Đếm Số',
        Icons.add_circle_outline,
        'Đếm Số',
        CountNumberContent.new,
      ),
      DrawerItem('Đồng Hồ', Icons.timer, 'Đồng Hồ', TimerPage.new),
    ],

    'Thực Tế': [
      DrawerItem('Lớp Học', Icons.school, 'Lớp Học', MyClassroom.new),
      DrawerItem(
        'Homestay',
        Icons.holiday_village,
        'Homestay',
        HomestayContent.new,
      ),
      DrawerItem('Địa Điểm', Icons.place, 'Địa Điểm', MyPlace.new),
    ],
    'API & Data': [
      DrawerItem('Sản Phẩm', Icons.shopping_bag, 'Sản Phẩm', MyProduct.new),
      DrawerItem(
        'Danh Sách Tin',
        Icons.newspaper,
        'Danh Sách Tin',
        NewsList.new,
      ),
      DrawerItem('Giỏ Hàng', Icons.shopping_cart, 'Giỏ Hàng', CartScreen.new),
      DrawerItem(
        'Danh Sách SP',
        Icons.grid_view,
        'Danh Sách SP',
        ProductListScreen.new,
      ),
    ],
    'Khác': [
      DrawerItem('Báo Cáo', Icons.assignment, 'Báo Cáo', ReportForm.new),
      DrawerItem(
        'Hướng Dẫn Layout',
        Icons.dashboard_customize,
        'Hướng Dẫn Layout',
        GuildToLayout.new,
      ),
      DrawerItem(
        'Trang Chủ Cũ',
        Icons.home_outlined,
        'Flutter Demo',
        MyHomePage.new,
      ),
    ],
  };

  void _navigateToPage(Widget page, String title) {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageWrapper(title: title, child: page),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      drawer: _buildDrawer(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _buildSearchSection(),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ..._buildDashboardContent(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nguyễn Văn Minh Nhật',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '22T1080023',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Trang Chủ'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Thông tin cá nhân'),
                  onTap: () =>
                      _navigateToPage(const ProfilePage(), 'Thông Tin Cá Nhân'),
                ),
                const Divider(),
                ..._drawerCategories.keys.map(
                  (title) => ExpansionTile(
                    leading: const Icon(Icons.folder_open),
                    title: Text(title),
                    children: _drawerCategories[title]!
                        .map(
                          (item) => ListTile(
                            leading: Icon(item.icon, size: 20),
                            title: Text(item.title),
                            onTap: () => _navigateToPage(
                              item.pageBuilder(),
                              item.pageTitle,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 32,
                              right: 16,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Đăng Xuất',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Navigate to Login Screen and remove all previous routes
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const FormLogin(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.blue,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text(
          'Flutter Learning Hub',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade400],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: -30,
                child: Icon(
                  Icons.flutter_dash,
                  size: 200,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Icon(
                      Icons.school,
                      size: 50,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
    );
  }

  Widget _buildSearchSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm bài tập...',
              prefixIcon: const Icon(Icons.search, color: Colors.blue),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDashboardContent() {
    List<Widget> slivers = [];

    _drawerCategories.forEach((category, items) {
      final filteredItems = items
          .where(
            (item) =>
                _searchQuery.isEmpty ||
                item.title.toLowerCase().contains(_searchQuery),
          )
          .toList();

      if (filteredItems.isNotEmpty) {
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        slivers.add(
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = filteredItems[index];
                return _buildCardItem(item);
              }, childCount: filteredItems.length),
            ),
          ),
        );
      }
    });

    if (slivers.isEmpty && _searchQuery.isNotEmpty) {
      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                Icon(Icons.search_off, size: 50, color: Colors.grey[400]),
                const SizedBox(height: 10),
                Text(
                  "Không tìm thấy kết quả nào",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return slivers;
  }

  Widget _buildCardItem(DrawerItem item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: Colors.blue.withOpacity(0.2),
      child: InkWell(
        onTap: () => _navigateToPage(item.pageBuilder(), item.pageTitle),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Icon(item.icon, size: 30, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final String pageTitle;
  final Widget Function() pageBuilder;

  const DrawerItem(this.title, this.icon, this.pageTitle, this.pageBuilder);
}
