import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/PaymentOption.dart';
import 'dart:ui';

import 'package:velocito/pages/Profile/ProfilePage.dart';

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
    ProfilePage(),
    PaymentOption(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        key: _key,
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                    icon: LineIcons.buffer,
                    text: 'Services',
                    textStyle: _style,
                  ),
                  GButton(
                    icon: LineIcons.wallet,
                    text: 'Wallet',
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
          ),
        ));
  }
}
