import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:day01/home.dart';
import 'package:day01/data/auth_service.dart';
import 'package:day01/form_register.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isObscure = true;
  String? _usernameError;
  String? _passwordError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo file JSON khi mở màn hình
    _authService.initAuthData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Validation
    String? userErr;
    String? passErr;
    
    if (username.isEmpty) {
      userErr = "Vui lòng nhập tên đăng nhập!";
    } else if (username.length < 3) {
      userErr = "Tên đăng nhập phải >= 3 ký tự!";
    }

    if (password.isEmpty) {
      passErr = "Vui lòng nhập mật khẩu!";
    } else if (password.length < 3) {
      passErr = "Mật khẩu phải >= 3 ký tự!";
    }

    setState(() {
      _usernameError = userErr;
      _passwordError = passErr;
    });

    if (userErr != null || passErr != null) return;

    setState(() => _isLoading = true);

    // Gọi AuthService login
    var result = await _authService.login(username, password);

    setState(() => _isLoading = false);

    if (result != null) {
      var user = result['user'];
      var token = result['token'];
      
      // Đăng nhập thành công
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Xin chào ${user['name']}!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      // Đăng nhập thất bại
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sai tên đăng nhập hoặc mật khẩu!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.login),
        title: const Text(
          "Đăng Nhập",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Xem dữ liệu JSON',
            onPressed: () async {
              var users = await _authService.getAllUsers();
              var path = await _authService.getFilePath();
              if (!context.mounted) return;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Dữ liệu Đăng Nhập (Debug)'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('📁 File Location:', 
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                          const SizedBox(height: 5),
                          SelectableText(path, 
                            style: const TextStyle(fontSize: 11, color: Colors.grey)),
                          const SizedBox(height: 15),
                          const Text('📊 Users:', 
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                          const SizedBox(height: 5),
                          SelectableText(
                            const JsonEncoder.withIndent('  ').convert(users),
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: const Text('Đóng')
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo/Icon
              Icon(Icons.lock_person, size: 80, color: Colors.blue.shade700),
              const SizedBox(height: 20),
              Text(
                'Chào mừng trở lại!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 40),
              
              // Username Field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Tên đăng nhập",
                  hintText: "Nhập tên đăng nhập",
                  border: const OutlineInputBorder(),
                  errorText: _usernameError,
                  prefixIcon: const Icon(Icons.person),
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),
              
              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  hintText: "Nhập mật khẩu",
                  border: const OutlineInputBorder(),
                  errorText: _passwordError,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _isObscure = !_isObscure),
                  ),
                ),
                enabled: !_isLoading,
                onSubmitted: (_) => _handleLogin(),
              ),
              const SizedBox(height: 24),
              
              // Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Đăng nhập",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              ),
              const SizedBox(height: 16),
              
              // Register Link
              TextButton(
                onPressed: _isLoading ? null : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FormRegister()),
                  );
                },
                child: const Text('Chưa có tài khoản? Đăng ký ngay'),
              ),
              
              // Hint
              const SizedBox(height: 20),
              Text(
                'Tài khoản mặc định:\nadmin / 123456\nnhat / 123',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
