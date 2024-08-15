import 'package:flutter/material.dart';
import 'package:flutter_and_excel/common/widgets/student%20_detail.dart';
import 'package:flutter_and_excel/core/secrets/secrets.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  final _gsheets = GSheets(credential);
  final _spreadsheetId = '17qd8Rp81NA0W2H5Bjd2p2olGDJYnB_dABElAstqNwxo';
  Worksheet? _worksheet;
  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
    getName();
    _fetchStudentData();
  }

  Future<void> _fetchStudentData() async {
    try {
      final ss = await _gsheets.spreadsheet(_spreadsheetId);
      _worksheet = ss.worksheetByTitle('All Students');
      if (_worksheet != null) {
        // Fetch all rows, including headers
        final allRows = await _worksheet!.values.allRows();
        print('All Rows: $allRows'); // Debug print

        if (allRows.length > 1) {
          // Assuming row 2 contains the headers
          final headers =
              allRows[1]; // Headers are in the second row (A2, B2, etc.)
          final dataRows =
              allRows.skip(2).toList(); // Data starts from the third row

          setState(() {
            _students = dataRows.map((row) {
              return {
                'roll_no': row[headers.indexOf('Roll No')],
                'name': row[headers.indexOf('Name')],
                'hostel_no': row[headers.indexOf('Hostel No.')],
                'floor': row[headers.indexOf('Floor')],
                'room_no': row[headers.indexOf('Room No.')],
                'room_type': row[headers.indexOf('Room Type')],
              };
            }).toList();
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    name = pref.getString('wardenName') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDFDFD),
              Color(0xFF43328B),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello $name Sir',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(
                      0xFF0D0339,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'All Students',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(
                      0xFF0D0339,
                    ),
                  ),
                ),
                Expanded(
                  child: _students.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: _students.length,
                          itemBuilder: (context, index) {
                            final student = _students[index];
                            return StudentDetail(
                                title: 'Roll No: ${student['roll_no']}',
                                subtitile:
                                    'Name: ${student['name']}, \nHostel: ${student['hostel_no']}, \nFloor: ${student['floor']}, \nRoom No: ${student['room_no']}, \nRoom Type: ${student['room_type']}');
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
