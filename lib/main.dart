import 'package:flutter/material.dart';
import 'package:flutter_and_excel/features/splash/screens/splash_screen.dart';

//create credentials

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Management',
      theme: ThemeData(
        brightness:
            Brightness.dark, // Use a dark theme to complement the background
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
