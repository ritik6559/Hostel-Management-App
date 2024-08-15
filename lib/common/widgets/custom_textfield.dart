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
          color: Colors.white, // Text color in dark mode
        ),
        controller: controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.white70, // Label color in dark mode
          ),
          filled: true,
          fillColor: const Color(0xFF1F1F1F), // Fill color for the text field in dark mode
          label: Text(
            hint, // Use the hint parameter for the label text
            style: const TextStyle(
              color: Colors.white70, // Label text color
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF434343), // Border color in dark mode
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFBB86FC), // Focused border color in dark mode
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
