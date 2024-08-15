import 'package:flutter/material.dart';
import 'package:flutter_and_excel/common/widgets/custom_button.dart';
import 'package:flutter_and_excel/common/widgets/custom_textfield.dart';
import 'package:flutter_and_excel/features/home/screens/home_screen.dart';
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
        height: double.infinity,
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/log_in_page.png',
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Welcome Sir!',
                    style: TextStyle(
                      color: Color(0xFF0D0339),
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Please enter your name',
                    style: TextStyle(
                      color: Color(0xFF0D0339),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    controller: _wardenNameController,
                    hint: 'Name',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onTap: _login,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 60.0,
                      vertical: 40,
                    ),
                    child: Divider(
                      thickness: 3,
                      color: Color(0xFF43328B),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
