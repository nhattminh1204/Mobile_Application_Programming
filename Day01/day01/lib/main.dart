import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day01/models/cart_model.dart';
import 'package:day01/form_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Learning Hub',
        theme: ThemeData(
          // Modern Minimal Color Palette
          scaffoldBackgroundColor: const Color(
            0xFFF8F9FC,
          ), // Soft gray background
          primaryColor: const Color(0xFF1A1D1F), // Dark charcoal primary
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1A1D1F),
            primary: const Color(0xFF1A1D1F),
            secondary: const Color(0xFF2E6FF2), // Vivid Blue accent
            surface: Colors.white,
            background: const Color(0xFFF8F9FC),
          ),
          useMaterial3: true,

          // Typography System (simulating Inter/Plus Jakarta Sans)
          fontFamily: 'Roboto', // Fallback, would use GoogleFonts in real prod
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1D1F),
              letterSpacing: -0.5,
            ),
            titleLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1D1F),
              letterSpacing: -0.5,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Color(0xFF6F767E),
              height: 1.5,
            ),
            labelLarge: TextStyle(fontWeight: FontWeight.w600),
          ),

          // Component Styles
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: false,
            iconTheme: IconThemeData(color: Color(0xFF1A1D1F)),
            titleTextStyle: TextStyle(
              color: Color(0xFF1A1D1F),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),

          cardTheme: const CardThemeData(
            // Changed from CardTheme to CardThemeData based on SDK 3.9 requirement
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(color: Color(0xFFF4F4F4), width: 1.5),
            ),
            margin: EdgeInsets.zero,
          ),

          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2E6FF2), width: 2),
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A1D1F),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
        home: const FormLogin(),
      ),
    );
  }
}
