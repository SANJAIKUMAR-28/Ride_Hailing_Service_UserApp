import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/Favourites.dart';
import 'package:velocito/pages/HomePage.dart';
import 'dart:ui';

import 'package:velocito/pages/Profile/ProfilePage.dart';
import 'package:velocito/pages/Profile/RideHistory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  static const TextStyle _style =
      TextStyle(fontFamily: 'Arimo', fontSize: 11, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Favourites(),
    RideHistory(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: Material(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GNav(
                  tabBackgroundColor: Color.fromRGBO(245, 245, 255, 1.0),
                  gap: 5,
                  padding: EdgeInsets.all(16),
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home',
                      textStyle: _style,
                    ),
                    GButton(
                      icon: LineIcons.heart,
                      text: 'Favourites',
                      textStyle: _style,
                    ),
                    GButton(
                      icon: LineIcons.history,
                      text: 'History',
                      textStyle: _style,
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                      textStyle: _style,
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            )));
  }
}
