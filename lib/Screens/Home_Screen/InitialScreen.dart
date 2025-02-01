import 'dart:ffi';
import 'dart:math';

import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/NotificationController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Account.dart';
import 'package:earnify_bole/Screens/Home_Screen/BookMark.dart';
import 'package:earnify_bole/Screens/Home_Screen/Home.dart';
import 'package:earnify_bole/Screens/Home_Screen/Notification.dart';
import 'package:earnify_bole/Screens/Home_Screen/Search.dart';
import 'package:earnify_bole/Screens/Home_Screen/Trending.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

class InitialHomeScreen extends StatefulWidget {
  const InitialHomeScreen({super.key});

  @override
  State<InitialHomeScreen> createState() => _InitialHomeScreenState();
}

class _InitialHomeScreenState extends State<InitialHomeScreen> {
 

  int selectedIndex = 0;
  List Pages = [
    HomeScreen(),
    TrendingScreen(),
    BookMarkScreen(),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        body: Stack(
      children: [
        Pages[selectedIndex],
 
      ],
),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 5),
          child:GNav(
            color: Color(0xFFA4634E),
            iconSize: 27,
            activeColor: Colors.white,
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            gap: 8,
            tabBackgroundColor: Color(0xFFA4634E),
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.local_fire_department,
                text: 'Trending',
                iconActiveColor: Colors.red,
                iconColor: Colors.red,
              ),
              GButton(
                icon: Icons.bookmark_outline,
                text: 'Booked',
              ),
              GButton(
                icon: Icons.person_2_outlined,
                text: 'Account',
              ),
            ],

        )));
  }
}
