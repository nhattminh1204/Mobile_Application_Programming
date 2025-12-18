import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'screens/user_management_screen.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  bool _isEditing = false;
  // Danh sách các mục bị ẩn (lưu tên title)
  List<String> _hiddenItems = [];
  late Map<String, List<DrawerItem>> _drawerCategories;

  bool get _isAdmin => widget.user['username'] == 'admin';

  @override
  void initState() {
    super.initState();
    _loadHiddenItems(); // Tải danh sách các mục đã ẩn
    _drawerCategories = {
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
  }

  // Tải danh sách hidden items từ SharedPreferences
  Future<void> _loadHiddenItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hiddenItems = prefs.getStringList('hidden_dashboard_items') ?? [];
    });
  }

  // Lưu danh sách hidden items
  Future<void> _saveHiddenItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('hidden_dashboard_items', _hiddenItems);
  }

  // Toggle ẩn/hiện item
  void _toggleItemVisibility(String title) {
    setState(() {
      if (_hiddenItems.contains(title)) {
        _hiddenItems.remove(title);
      } else {
        _hiddenItems.add(title);
      }
    });
    _saveHiddenItems();
  }

  // Khôi phục tất cả các mục đã ẩn
  Future<void> _resetDashboard() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Khôi phục Dashboard'),
        content: const Text('Bạn có muốn hiển thị lại tất cả các mục đã bị ẩn không?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Khôi phục')),
        ],
      ),
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('hidden_dashboard_items');
      setState(() {
        _hiddenItems = [];
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã khôi phục toàn bộ danh sách chức năng')),
      );
    }
  }

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
          if (_isAdmin) _buildAdminStats(),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _buildSearchSection(),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ..._buildDashboardContent(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
      floatingActionButton: _isAdmin
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              label: Text(_isEditing ? 'Hoàn tất' : 'Quản lý Menu'),
              icon: Icon(_isEditing ? Icons.check : Icons.edit),
              backgroundColor: _isEditing ? Colors.green : Colors.blue,
              foregroundColor: Colors.white,
            )
          : null,
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
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.user['name'] ?? 'Guest',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '@${widget.user['username']}',
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
                      _navigateToPage(ProfilePage(user: widget.user), 'Thông Tin Cá Nhân'),
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
                if (_isAdmin) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'QUẢN TRỊ HỆ THỐNG',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.manage_accounts, color: Colors.blueAccent),
                    title: const Text('Quản lý người dùng'),
                    onTap: () => _navigateToPage(const UserManagementScreen(), 'Quản Lý Người Dùng'),
                  ),
                  ListTile(
                    leading: Icon(
                      _isEditing ? Icons.dashboard_customize : Icons.edit_note,
                      color: _isEditing ? Colors.green : Colors.orange,
                    ),
                    title: Text(_isEditing ? 'Đang chỉnh sửa Menu...' : 'Chỉnh sửa Dashboard'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _isEditing = !_isEditing);
                    },
                  ),
                  const Divider(),
                ],
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

  Widget _buildAdminStats() {
    int totalItems = 0;
    _drawerCategories.forEach((_, list) => totalItems += list.length);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng quan hệ thống',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (_hiddenItems.isNotEmpty)
                  TextButton.icon(
                    onPressed: _resetDashboard,
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Khôi phục menu', style: TextStyle(fontSize: 12)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatCard('Chức năng', totalItems.toString(), Icons.apps, Colors.blue),
                const SizedBox(width: 12),
                _buildStatCard('Đang ẩn', _hiddenItems.length.toString(), Icons.visibility_off, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: color.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
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
      final filteredItems = items.where((item) {
        // Lọc theo search
        final matchesSearch = _searchQuery.isEmpty ||
            item.title.toLowerCase().contains(_searchQuery);

        // Lọc theo trạng thái ẩn/hiện
        // Nếu là Admin đang Edit: Hiện tất cả (kể cả ẩn)
        // Nếu không: Chỉ hiện những cái KHÔNG có trong _hiddenItems
        final isHidden = _hiddenItems.contains(item.title);
        final shouldShow = (_isAdmin && _isEditing) || !isHidden;

        return matchesSearch && shouldShow;
      }).toList();

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
                childAspectRatio: 1.3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
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
    bool isHidden = _hiddenItems.contains(item.title);

    // Ở chế độ hiển thị bình thường (không phải admin edit), card hoạt động như cũ
    // Ở chế độ Edit, nếu bị ẩn thì cho mờ đi
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: isHidden ? 0.5 : 1.0, 
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isHidden && _isEditing 
                ? null // Không click được khi đang ẩn ở chế độ edit
                : () => _navigateToPage(item.pageBuilder(), item.pageTitle),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Colors.blue.withOpacity(0.05)],
                    ),
                    border: Border.all(
                      color: isHidden ? Colors.grey : Colors.white.withOpacity(0.8),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isHidden ? Colors.grey[200] : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          item.icon,
                          size: 32,
                          color: isHidden ? Colors.grey : Colors.blue.shade600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: isHidden ? Colors.grey : Colors.grey.shade800,
                          height: 1.2,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_isEditing)
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                _toggleItemVisibility(item.title);
                
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isHidden 
                      ? 'Đã khôi phục ${item.title}' 
                      : 'Đã ẩn ${item.title}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isHidden ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isHidden ? Colors.green : Colors.red,
                    width: 1
                  )
                ),
                child: Icon(
                  isHidden ? Icons.visibility : Icons.visibility_off,
                  color: isHidden ? Colors.green : Colors.red, 
                  size: 18
                ),
              ),
            ),
          ),
      ],
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
