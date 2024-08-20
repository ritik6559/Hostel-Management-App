import 'package:flutter/material.dart';
import 'package:flutter_and_excel/core/secrets/secrets.dart';
import 'package:gsheets/gsheets.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddEntryScreen(),
    );
  }
}

class AddEntryScreen extends StatefulWidget {
  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _rollNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _hostelNoController = TextEditingController();
  final _floorController = TextEditingController();
  final _roomNoController = TextEditingController();
  final _roomTypeController = TextEditingController();

  Worksheet? worksheet;

  @override
  void initState() {
    super.initState();
    _initGSheets();
  }

  Future<void> _initGSheets() async {
    final gsheets = GSheets(credential);
    final spreadsheet = await gsheets.spreadsheet(spreadSheetId);
    setState(() {
      worksheet = spreadsheet.worksheetByTitle('All Students');
    });
  }

  Future<void> addEntry(String rollNumber, String name, String hostelNo, String floor, String roomNo, String roomType) async {
    if (worksheet == null) return;

    // Get the current number of rows (to calculate the SNo.)
    final currentRows = await worksheet!.values.allRows();
    final sno = currentRows.length + 1;

    // Append a new row with the appropriate data
    await worksheet!.values.appendRow([sno.toString(), rollNumber, name, hostelNo, floor, roomNo, roomType]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _rollNumberController,
                decoration: InputDecoration(labelText: 'Roll Number'),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _hostelNoController,
                decoration: InputDecoration(labelText: 'Hostel No.'),
              ),
              TextField(
                controller: _floorController,
                decoration: InputDecoration(labelText: 'Floor'),
              ),
              TextField(
                controller: _roomNoController,
                decoration: InputDecoration(labelText: 'Room No.'),
              ),
              TextField(
                controller: _roomTypeController,
                decoration: InputDecoration(labelText: 'Room Type'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final rollNumber = _rollNumberController.text;
                  final name = _nameController.text;
                  final hostelNo = _hostelNoController.text;
                  final floor = _floorController.text;
                  final roomNo = _roomNoController.text;
                  final roomType = _roomTypeController.text;

                  await addEntry(rollNumber, name, hostelNo, floor, roomNo, roomType);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Entry added successfully!')),
                  );

                  // Clear the text fields after adding the entry
                  _rollNumberController.clear();
                  _nameController.clear();
                  _hostelNoController.clear();
                  _floorController.clear();
                  _roomNoController.clear();
                  _roomTypeController.clear();
                },
                child: Text('Add Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
