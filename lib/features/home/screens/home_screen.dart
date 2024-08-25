import 'package:flutter/material.dart';
import 'package:flutter_and_excel/models/hostel_model.dart';
import 'package:flutter_and_excel/features/home/widget/hostel_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';

  @override
  void initState() {
    super.initState();
    getName();
  }

  List<HostelModel> hostels = [
    HostelModel(
      name: 'Azad',
      color: Color(0xFFdee8ff),
      hostelNo: ['h14','h-8','h-9','h-10'],
    ),
    HostelModel(
      name: 'Geeta',
      color: Color(0xFFfcd4cb),
      hostelNo: ['H12'],
    ),
    HostelModel(
      name: 'Parmar',
      color: Color(0xFFff785a),
      hostelNo: [
        'h15',
      ],
    ),
    HostelModel(
      name: 'Shastri',
      color: Color(0xFFfcd4cb),
      hostelNo: [
        'h1',
        'h2',
        'h3',
        'h4',
        'h5',
        'h6',
        'h7',
        'h8',
        'h9',
        'h10',
        'h11'
      ],
    ),
  ];

  getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('wardenName') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello $name Sir',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFfbfbfb),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hostels.length,
                  itemBuilder: (context, index) {
                    final hostel = hostels[index];
                    return HostelTile(
                      hostel: hostel,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
