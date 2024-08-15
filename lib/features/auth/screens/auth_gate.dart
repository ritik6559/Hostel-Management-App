import 'package:flutter/material.dart';
import 'package:flutter_and_excel/features/auth/screens/log_in_screen.dart';
import 'package:flutter_and_excel/features/home/widget/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatefulWidget {
  AuthGate({super.key});

  @override
  State<AuthGate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AuthGate> {
  String name = '';

  @override
  void initState() {
    super.initState();
    getName();
  }

  getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    name = pref.getString('wardenName') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (name.isEmpty) {
      return const LoginScreen();
    }
    return const BottomNavBar();
  }
}
