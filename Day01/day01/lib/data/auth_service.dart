import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _storageKey = 'auth_data';

  // Lấy dữ liệu từ SharedPreferences (hoạt động trên cả Web và Mobile)
  Future<Map<String, dynamic>> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    
    if (jsonString == null) {
      // Khởi tạo dữ liệu mặc định
      Map<String, dynamic> initialData = {
        "users": [
          {"username": "admin", "password": "123456", "name": "Administrator"},
          {"username": "nhat", "password": "123", "name": "Minh Nhật"}
        ]
      };
      await _saveData(initialData);
      print("✅ Created auth data in SharedPreferences");
      return initialData;
    }
    
    print("✅ Auth data loaded from SharedPreferences");
    return jsonDecode(jsonString);
  }

  // Lưu dữ liệu vào SharedPreferences
  Future<void> _saveData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(data));
  }

  // Lấy đường dẫn file (cho debug - trả về storage key)
  Future<String> getFilePath() async {
    return 'SharedPreferences: $_storageKey';
  }

  // Khởi tạo dữ liệu (tự động gọi trong _getData)
  Future<void> initAuthData() async {
    await _getData(); // Sẽ tự tạo nếu chưa có
  }

  // Đăng nhập trả về Token + User Info
  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      Map<String, dynamic> data = await _getData();
      List<dynamic> users = data['users'];

      for (var user in users) {
        if (user['username'] == username && user['password'] == password) {
          // Xóa password trước khi trả về
          Map<String, dynamic> responseUser = Map.from(user);
          responseUser.remove('password');
          
          // Tạo Mock JWT Token
          String token = _generateJwtToken(username);
          
          print("✅ Login successful: $username");
          return {
            "user": responseUser,
            "token": token
          };
        }
      }
      print("❌ Login failed: Invalid credentials");
    } catch (e) {
      print("❌ Error during login: $e");
    }
    return null;
  }

  // Giả lập tạo JWT Token
  String _generateJwtToken(String username) {
    String header = base64Url.encode(utf8.encode(jsonEncode({"alg": "HS256", "typ": "JWT"})));
    String payload = base64Url.encode(utf8.encode(jsonEncode({
      "sub": username,
      "name": username,
      "iat": DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "exp": (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600
    })));
    String signature = base64Url.encode(utf8.encode("secret_key_mock"));
    return "$header.$payload.$signature";
  }
  
  // Lấy danh sách user (debug)
  Future<List<dynamic>> getAllUsers() async {
    try {
      Map<String, dynamic> data = await _getData();
      return data['users'];
    } catch (e) {
      print("❌ Error getting users: $e");
      return [];
    }
  }

  // Đăng ký tài khoản mới
  Future<bool> register(String username, String password, String name) async {
    try {
      Map<String, dynamic> data = await _getData();
      List<dynamic> users = data['users'];

      // Kiểm tra username đã tồn tại
      for (var user in users) {
        if (user['username'] == username) {
          print("❌ Registration failed: Username exists");
          return false;
        }
      }

      // Thêm user mới
      users.add({
        "username": username,
        "password": password,
        "name": name,
      });

      data['users'] = users;
      await _saveData(data);
      print("✅ Registration successful: $username");
      return true;
    } catch (e) {
      print("❌ Error during registration: $e");
      return false;
    }
  }
  // Xóa tài khoản (chỉ dành cho Admin)
  Future<bool> deleteUser(String username) async {
    try {
      if (username == 'admin') return false; // Không cho phép xóa admin gốc

      Map<String, dynamic> data = await _getData();
      List<dynamic> users = data['users'];

      int lengthBefore = users.length;
      users.removeWhere((u) => u['username'] == username);

      if (users.length < lengthBefore) {
        data['users'] = users;
        await _saveData(data);
        print("✅ User deleted: $username");
        return true;
      }
    } catch (e) {
      print("❌ Error deleting user: $e");
    }
    return false;
  }
}
