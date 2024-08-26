import 'package:flutter/material.dart';
import 'package:flutter_and_excel/features/splash/screens/splash_screen.dart';


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
            Brightness.light,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
