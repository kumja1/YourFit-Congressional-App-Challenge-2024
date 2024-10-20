import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourfit/src/app_router.gr.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        RoadmapRoute(),
        ProfileRoute(),
        FriendsRoute(),
      ],
      bottomNavigationBuilder: (builder, router) {
        return NavigationBar(
            selectedIndex: router.activeIndex,
            onDestinationSelected: (i) => router.setActiveIndex(i),
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
            ]);
      },
    );
  }
}
