
import 'package:flutter/material.dart';

class StudentDetail extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;

  const StudentDetail({
    super.key,
    required this.title,
    required this.subtitle,
    this.backgroundColor = Colors.grey,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: subtitleColor),
        ),
      ),
    );
  }
}