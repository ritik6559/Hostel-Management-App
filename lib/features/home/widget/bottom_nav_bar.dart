import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_and_excel/features/home/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<BottomNavBar> {
  int currentPage = 0;
  List<Widget> screens = const [
    HomeScreen(),
    Scaffold(
      body: Center(
        child: Text("Search"),
      ),
    ),
    Scaffold(
      body: Text('add'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 13, 3, 57).withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          currentPage = 0;
                        },
                      );
                    },
                    icon: Icon(
                      size: 35,
                      currentPage == 0
                          ? CupertinoIcons.house_alt_fill
                          : CupertinoIcons.house_alt,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: currentPage == 0
                            ? FontWeight.w900
                            : FontWeight.normal),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 1;
                      });
                    },
                    icon: Icon(
                      size: 35,
                      currentPage == 1
                          ? CupertinoIcons.search_circle_fill
                          : CupertinoIcons.search,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: currentPage == 1
                            ? FontWeight.w900
                            : FontWeight.normal),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          currentPage = 2;
                        },
                      );
                    },
                    icon: Icon(
                      size: 35,
                      currentPage == 2 ? Icons.add : Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Add Student",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: currentPage == 2
                          ? FontWeight.w900
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: screens[currentPage]);
  }
}
