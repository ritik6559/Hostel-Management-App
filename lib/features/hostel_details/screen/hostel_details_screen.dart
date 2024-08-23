import 'package:flutter/material.dart';
import 'package:flutter_and_excel/features/home/models/hostel_model.dart';
import 'package:gsheets/gsheets.dart';

class HostelDetailsScreen extends StatefulWidget {
  final HostelModel hostel;
  const HostelDetailsScreen({super.key, required this.hostel});

  @override
  State<HostelDetailsScreen> createState() => _HostelDetailsScreenState();
}

class _HostelDetailsScreenState extends State<HostelDetailsScreen> {
  final TextEditingController controller = TextEditingController();


  String _selectedSearchType = 'Name';
  List<List<String>> _searchResults = [];
  Worksheet? _worksheet;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfbfbfb),
      appBar: AppBar(
        title: Text(
          widget.hostel.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(
                Icons.search,
              ),
            ),
            onChanged: (value) => _performSearch(value),
          ),
          Wrap(
            spacing: 8.0,
            children: ['Name', 'Roll No.', 'Floor'].map(
              (type) {
                return ChoiceChip(
                  label: Text('Search By $type'),
                  selected: _selectedSearchType == type,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedSearchType = type);
                      _performSearch(controller.text);
                    }
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
