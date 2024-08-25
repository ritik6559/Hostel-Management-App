import 'package:flutter/material.dart';
import 'package:flutter_and_excel/models/student_model.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final Color color;
  const StudentCard({
    super.key,
    required this.student,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.name,
                style: TextStyle(
                    color: Color(0xFF1f3854),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text('Roll No: ${student.rollNo}'),
              Text('Room: ${student.roomNo}'),
              Text('Floor: ${student.floor}'),
              Text('Hostel: ${student.hostel}'),
              Text('Student\' phone no: ${student.studentPhoneNo}'),
              Text('Parents\' phone no: ${student.parentPhoneNo}'),
            ],
          )),
    );
  }
}
