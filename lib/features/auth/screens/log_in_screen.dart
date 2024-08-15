import 'package:flutter/material.dart';
import 'package:flutter_and_excel/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _wardenNameController = TextEditingController();
  



  Future<void> _saveWardenName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wardenName', _wardenNameController.text);
  }

  void _login() {
    _saveWardenName().then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDFDFD),
              Color(0xFF43328B),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          
        ),
      ),
    );
  }
}
