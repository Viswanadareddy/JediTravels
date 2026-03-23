import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';
import 'package:loginout/dashboard.dart';
import 'package:loginout/offers.dart';
import 'package:loginout/settings.dart';
import 'package:loginout/profile.dart';
//import 'package:loginout/screens/home/components/popular.dart';
//import 'package:loginout/screens/home/components/show_all.dart';
//import 'package:loginout/screens/home/components/header_with_search.dart';
//import 'package:loginout/screens/home/components/recomend_hotels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    Offers(),
    Profile(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home), 
            label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_offer_outlined),
              selectedIcon: Icon(Icons.local_offer),
               label: 'Offers'),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person), 
              label: 'Profile'),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings), 
              label: 'Settings'),
        ],
        ),
      body: _children[_currentIndex],
    );
  }
}

