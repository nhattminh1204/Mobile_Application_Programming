import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback? onBack;

  const PageWrapper({
    Key? key,
    required this.child,
    required this.title,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack ?? () => Navigator.of(context).pop(),
          tooltip: 'Quay lại',
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}