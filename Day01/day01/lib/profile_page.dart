import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> user;
  const ProfilePage({super.key, required this.user});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FC),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top Gradient Section mimicking the old header background
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade700,
                        Colors.blue.shade400,
                        Colors.cyan.shade300,
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Icon(
                          Icons.person,
                          size: 200,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
                // Avatar with shadow (positioned to overlap)
                Positioned(
                  bottom: -60,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 70), // Space for the overlapping avatar

            // Name with style
            Text(
              user['name'] ?? 'Unknown User',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            // Role badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: user['username'] == 'admin' 
                    ? [Colors.red.shade400, Colors.orange.shade400]
                    : [Colors.blue.shade400, Colors.cyan.shade300],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                user['username'] == 'admin' ? 'Administrator' : 'Người dùng hệ thống',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Info Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildModernInfoCard(
                    icon: Icons.account_circle,
                    title: 'Tên đăng nhập',
                    value: user['username'] ?? 'N/A',
                    color: const Color(0xFF7E57C2), // Purple
                  ),
                  const SizedBox(height: 16),
                  _buildModernInfoCard(
                    icon: Icons.vpn_key,
                    title: 'Trạng thái tài khoản',
                    value: user['username'] == 'admin' ? 'Quyền tối cao' : 'Thành viên',
                    color: const Color(0xFFEC407A), // Pink
                  ),
                  const SizedBox(height: 16),
                  _buildModernInfoCard(
                    icon: Icons.security,
                    title: 'Bảo mật',
                    value: 'Mã hóa JWT Hoạt động',
                    color: const Color(0xFF42A5F5), // Blue
                  ),
                  const SizedBox(height: 16),
                  _buildModernInfoCard(
                    icon: Icons.verified_user,
                    title: 'Xác minh',
                    value: 'Đã xác thực',
                    color: const Color(0xFF26A69A), // Teal
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildModernInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Icon with gradient background
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),

            const SizedBox(width: 16),

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
