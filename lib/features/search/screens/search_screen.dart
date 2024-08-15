import 'package:flutter/material.dart';
import 'package:flutter_and_excel/common/widgets/student%20_detail.dart';
import 'package:flutter_and_excel/core/secrets/secrets.dart';
import 'package:gsheets/gsheets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSearchType = 'Name';
  List<List<String>> _searchResults = [];
  Worksheet? _worksheet;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initGSheets();
  }

  Future<void> _initGSheets() async {
    setState(() => _isLoading = true);

    final gsheets = GSheets(credential);

    try {
      // Open the spreadsheet by its ID
      final spreadsheet = await gsheets.spreadsheet(spreadSheetId);

      // Get the worksheet by its title
      _worksheet = await spreadsheet.worksheetByTitle('All Students');

      if (_worksheet == null) {
        print('Worksheet not found');
        // Handle the error appropriately
      }
    } catch (e) {
      print('Error initializing GSheets: $e');
      // Handle the error appropriately
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _performSearch(String query) async {
    if (_worksheet == null) return;

    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    // Get all rows from the worksheet
    final allRows = await _worksheet!.values.allRows();

    _searchResults = allRows.skip(2).where((row) {
      if (row.length < 7) return false; // Ensure the row has enough columns

      bool matchFound = false;
      switch (_selectedSearchType) {
        case 'Name':
          matchFound = row[2].toLowerCase().contains(query.toLowerCase());
          break;
        case 'Roll No.':
          // For roll numbers, we'll check if the query is a substring of the roll number
          // This allows searching by partial roll numbers
          matchFound = row[1].contains(query);
          break;
        case 'Floor':
          matchFound = row[4].toLowerCase().contains(query.toLowerCase());
          break;
      }

      return matchFound;
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Search')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
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
                            _performSearch(_searchController.text);
                          }
                        },
                      );
                    },
                  ).toList(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      var result = _searchResults[index];
                      return StudentDetail(
                        title: result[1],
                        subtitle:
                            'Name: ${result[2]} \nFloor: ${result[4]} \nRoom: ${result[5]}',
                        backgroundColor: Colors.grey[900]!,
                        titleColor: Colors.white,
                        subtitleColor: Colors.white70,
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
