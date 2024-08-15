import 'package:flutter/material.dart';
import 'package:flutter_and_excel/features/auth/screens/log_in_screen.dart';
import 'package:flutter_and_excel/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWidget extends StatefulWidget {
  MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late String name;

  @override
  void initState() {
    super.initState();
    getName();
  }

  getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('wardenName') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (name.isEmpty) {
      return LoginScreen();
    }
    return const HomeScreen();
  }
}
