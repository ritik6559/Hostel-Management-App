import 'package:flutter/material.dart';
import 'package:flutter_and_excel/features/home/models/hostel_model.dart';
import 'package:flutter_and_excel/features/hostel_details/screen/hostel_details_screen.dart';

class HostelTile extends StatelessWidget {
  final HostelModel hostel;
  const HostelTile({
    super.key,
    required this.hostel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HostelDetailsScreen(
              hostel: hostel,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(
          15,
        ),
        padding: const EdgeInsets.all(
          20,
        ),
        width: 300,
        decoration: BoxDecoration(
          color: hostel.color,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hostel.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1f3854),
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
