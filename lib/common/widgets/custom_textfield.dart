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
          color: Colors.black, // Text color in dark mode
        ),
        controller: controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.black, // Label color in dark mode
          ),
          filled: true,
          fillColor: Colors.grey.shade200, // Fill color for the text field in dark mode
          label: Text(
            hint, // Use the hint parameter for the label text
            style: const TextStyle(
              color: Colors.black, // Label text color
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
