import 'package:flutter/material.dart';
import 'package:day01/data/auth_service.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  final AuthService _authService = AuthService();

  bool _isObscurePassword = true;
  bool _isObscureConfirm = true;
  bool _isLoading = false;

  String? _nameError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    String name = _nameController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Validation Logic
    String? nameErr;
    String? userErr;
    String? passErr;
    String? confirmErr;

    if (name.isEmpty) {
      nameErr = "Vui lòng nhập họ tên!";
    } else if (name.length < 2) {
      nameErr = "Họ tên quá ngắn!";
    }
    
    if (username.isEmpty) {
      userErr = "Vui lòng nhập tên đăng nhập!";
    } else if (username.length < 3) {
      userErr = "Tên đăng nhập phải >= 3 ký tự!";
    } else if (username.contains(' ')) {
      userErr = "Tên đăng nhập không được chứa khoảng trắng!";
    }

    if (password.isEmpty) {
      passErr = "Vui lòng nhập mật khẩu!";
    } else if (password.length < 6) {
      passErr = "Mật khẩu phải >= 6 ký tự!";
    }

    if (confirmPassword.isEmpty) {
      confirmErr = "Vui lòng xác nhận mật khẩu!";
    } else if (password != confirmPassword) {
      confirmErr = "Mật khẩu xác nhận không khớp!";
    }

    setState(() {
      _nameError = nameErr;
      _usernameError = userErr;
      _passwordError = passErr;
      _confirmPasswordError = confirmErr;
    });

    if (nameErr != null || userErr != null || passErr != null || confirmErr != null) {
      return;
    }

    setState(() => _isLoading = true);

    // Process Registration
    bool success = await _authService.register(username, password, name);
    
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Đăng ký thành công! Vui lòng đăng nhập.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Tên đăng nhập đã tồn tại!'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Đăng Ký Tài Khoản",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon
              Icon(Icons.person_add, size: 80, color: Colors.blue.shade700),
              const SizedBox(height: 20),
              Text(
                'Tạo tài khoản mới',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 40),
              
              // Name Field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Họ và tên",
                  hintText: "Nhập họ và tên đầy đủ",
                  border: const OutlineInputBorder(),
                  errorText: _nameError,
                  prefixIcon: const Icon(Icons.badge),
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),
              
              // Username Field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Tên đăng nhập",
                  hintText: "Tối thiểu 3 ký tự, không dấu cách",
                  border: const OutlineInputBorder(),
                  errorText: _usernameError,
                  prefixIcon: const Icon(Icons.account_circle),
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),
              
              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: _isObscurePassword,
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  hintText: "Tối thiểu 6 ký tự",
                  border: const OutlineInputBorder(),
                  errorText: _passwordError,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _isObscurePassword = !_isObscurePassword),
                  ),
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),
              
              // Confirm Password Field
              TextField(
                controller: _confirmPasswordController,
                obscureText: _isObscureConfirm,
                decoration: InputDecoration(
                  labelText: "Xác nhận mật khẩu",
                  hintText: "Nhập lại mật khẩu",
                  border: const OutlineInputBorder(),
                  errorText: _confirmPasswordError,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscureConfirm ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _isObscureConfirm = !_isObscureConfirm),
                  ),
                ),
                enabled: !_isLoading,
                onSubmitted: (_) => _handleRegister(),
              ),
              const SizedBox(height: 24),
              
              // Register Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isLoading ? null : _handleRegister,
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
                        Icon(Icons.app_registration, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Đăng ký",
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
              
              // Back to Login
              TextButton.icon(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Quay lại đăng nhập"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
