import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Color(
            0xFF0D0339,
          ),
        ),
        controller: controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Color(0xFF43328B),
          ),
          filled: true,
          fillColor: Colors.white,
          label: const Text(
            "Enter your name",
            style: TextStyle(
              color: Color(0xFF0D0339),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
