import 'package:flutter/material.dart';
import 'tabs/index.dart';
import 'other/index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _screens = <Widget>[
    RoadmapScreen(),
    ProfileScreen(),
    SettingsScreen(),
    FriendsScreen(),

  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.map),
            label: 'Roadmap',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_run),
            label: 'Exercise',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt),
            label: 'Friends',
          ),
        ],
      ),
    );
  }
}
