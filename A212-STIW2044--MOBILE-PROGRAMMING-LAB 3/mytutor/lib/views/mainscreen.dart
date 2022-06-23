import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'subjectpage.dart';
import 'tutorpage.dart';

import '../models/user.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      '',
      style: optionStyle,
    ),
    Text(
      '',
      style: optionStyle,
    ),
    Text(
      '',
      style: optionStyle,
    ),
    Text(
      '',
      style: optionStyle,
    ),
    Text(
      '',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tutor App'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
     bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 60.0,
              items: <Widget>[
              SizedBox(
                  height: 50,
                  child: Column(
                    children: const [Icon(Icons.book, size: 30), Text("Subject")],
                  ),
                ),
                
                SizedBox(
                  height: 50,
                  child: Column(
                    children: const [Icon(Icons.person_add_rounded, size: 30), Text("Tutors")],
                  ),
                ),
                 SizedBox(
                  height: 50,
                  child: Column(
                    children: const [Icon(Icons.favorite, size: 30), Text("Favorite")],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Column(
                    children: const [Icon(Icons.people_alt_rounded, size: 30), Text("Profile")],
                  ),
                  
                  
                ),
              ],
        onTap: _onItemTap,
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>  SubjectScreen( user: widget.user,)));
          break;
        case 1:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>  TutorScreen(user: widget.user,)));
          break;
        
      }
    });
  }
}