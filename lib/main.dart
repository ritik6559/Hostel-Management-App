import 'package:flutter/material.dart';
import 'package:flutter_and_excel/core/secrets/secrets.dart';
import 'package:flutter_and_excel/features/splash/screens/splash_screen.dart';
import 'package:gsheets/gsheets.dart';

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

class HostelDataScreen extends StatefulWidget {
  @override
  _HostelDataScreenState createState() => _HostelDataScreenState();
}

class _HostelDataScreenState extends State<HostelDataScreen> {
  final _gsheets = GSheets(credential);
  final _spreadsheetId = '17qd8Rp81NA0W2H5Bjd2p2olGDJYnB_dABElAstqNwxo';
  Worksheet? _worksheet;
  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
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

        if (allRows != null && allRows.length > 1) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hostel Management',
        ),
      ),
      body: _students.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return ListTile(
                  title: Text('Roll No: ${student['roll_no']}'),
                  subtitle: Text(
                      'Name: ${student['name']}, Hostel: ${student['hostel_no']}, Floor: ${student['floor']}, Room No: ${student['room_no']}, Room Type: ${student['room_type']}'),
                );
              },
            ),
    );
  }
}
