import 'package:flutter/material.dart';

class StudentDetail extends StatelessWidget {
  final String title;
  final String subtitile;
  const StudentDetail({
    super.key,
    required this.title,
    required this.subtitile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(
          0xFF0D0339,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          subtitile,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
