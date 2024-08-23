import 'package:flutter/material.dart';
import 'package:flutter_and_excel/core/secrets/secrets.dart';
import 'package:flutter_and_excel/features/hostel_details/widgets/student_card.dart';
import 'package:flutter_and_excel/models/hostel_model.dart';
import 'package:flutter_and_excel/models/student_model.dart';
import 'package:gsheets/gsheets.dart';

class HostelDetailsScreen extends StatefulWidget {
  final HostelModel hostel;

  HostelDetailsScreen({required this.hostel});

  @override
  _HostelDetailsScreenState createState() => _HostelDetailsScreenState();
}

class _HostelDetailsScreenState extends State<HostelDetailsScreen> {
  List<Student> students = [];
  List<Student> filteredStudents = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  String selectedChip = 'name';

  @override
  void initState() {
    super.initState();
    fetchStudentsFromSheets();
  }

  Future<void> fetchStudentsFromSheets() async {
    print(('hello 1'));
    final gsheets = GSheets(credential);
    print('hello2');
    final ss = await gsheets.spreadsheet(spreadSheetId);
    print("hello");
    final sheet = await ss.worksheetByTitle('All Students');

    if (sheet == null) {
      print('Sheet not found');
      setState(() => isLoading = false);
      return;
    }

    final rows = await sheet.values.allRows();
    print(rows.length);

    // Assuming the first row is headers
    for (var i = 2; i < rows.length; i++) {
      final row = rows[i];
      if (row.length >= 4 && isStudentInHostel(row[3])) {
        students.add(Student(
          name: row[2],
          rollNo: row[1],
          roomNo: row[5],
          floor: row[4],
          hostel: row[3],
        ));
      }
    }

    setState(() {
      filteredStudents = students;
      isLoading = false;
    });
  }

  bool isStudentInHostel(String roomNo) {
    for (String hostelNumber in widget.hostel.hostelNo) {
      if (roomNo.toLowerCase().startsWith(hostelNumber.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  void filterStudents(String query) {
    setState(() {
      filteredStudents = students.where((student) {
        switch (selectedChip) {
          case 'name':
            return student.name.toLowerCase().contains(query.toLowerCase());
          case 'rollNo':
            return student.rollNo.toLowerCase().contains(query.toLowerCase());
          case 'floor':
            return student.floor.toLowerCase().contains(query.toLowerCase());
          default:
            return false;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.hostel.name} Hostel Details')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: filterStudents,
                  ),
                ),
                Wrap(
                  spacing: 8.0,
                  children: [
                    ChoiceChip(
                      label: Text('Name'),
                      selected: selectedChip == 'name',
                      onSelected: (selected) {
                        setState(() {
                          selectedChip = 'name';
                          filterStudents(searchController.text);
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('Roll No'),
                      selected: selectedChip == 'rollNo',
                      onSelected: (selected) {
                        setState(() {
                          selectedChip = 'rollNo';
                          filterStudents(searchController.text);
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('Floor'),
                      selected: selectedChip == 'floor',
                      onSelected: (selected) {
                        setState(() {
                          selectedChip = 'floor';
                          filterStudents(searchController.text);
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return StudentCard(
                        student: student,
                        color: widget.hostel.color,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
