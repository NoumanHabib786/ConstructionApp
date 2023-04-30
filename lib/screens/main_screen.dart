import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'material_screen.dart';
import 'profile_screen.dart';
import 'labour_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _screens = [
    MaterialScreen(),
    LabourScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        title: const Text(
          "Construction Build Environment",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
      ),
      drawer: Drawer(
        elevation: 27,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  "Salam!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text("Vendor"),
              subtitle: Text("Old one"),
              trailing: Icon(Icons.verified_user),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'settingScreen');
              },
              child: const ListTile(
                leading: Icon(Icons.settings_accessibility_rounded),
                title: Text("Setting"),
                trailing: Icon(Icons.settings),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'loginScreen');
              },
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        // backgroundColor: Colors.deepPurple,
        backgroundColor: Colors.blueGrey,
        items: const [
          Icon(Icons.home),
          Icon(Icons.person),
          Icon(Icons.person_pin_circle),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
