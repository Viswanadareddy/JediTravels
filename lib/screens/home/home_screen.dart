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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => IconButton(
                icon: Opacity(
                  opacity: 1.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_bottomappbaritems[index],
                          color: index == _currentIndex
                              ? Constants.buttonColor
                              : Constants.textColor),
                      index == _currentIndex ? Spacer() : SizedBox(),
                    ],
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}

final List<IconData> _bottomappbaritems = const <IconData>[
  Icons.home,
  Icons.local_offer,
  Icons.person,
  Icons.settings,
];
