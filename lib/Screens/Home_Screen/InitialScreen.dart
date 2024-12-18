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
        
          Positioned(
  bottom: 2,
  left: 0,
  right: 0,
  child: Container(
height: 60, 
width: MediaQuery.of(context).size.width,// Add a fixed height for the banner ad
    alignment: Alignment.center,
child: AdWidget(ad: AdMobHelper.getBannerAd(context)..load(),
    key: UniqueKey(),
),
    
  ),
),
      ],
),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 5),
          child:GNav(
            backgroundColor: Colors.white,
            color: Colors.grey[600],
            iconSize: 27,
            activeColor: Colors.black,
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            gap: 8,
            tabBackgroundColor: const Color.fromARGB(255, 236, 235, 235),
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
                textColor: Colors.red,
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
