import 'package:earnify_bole/Screens/Home_Screen/Account.dart';
import 'package:earnify_bole/Screens/Home_Screen/BookMark.dart';
import 'package:earnify_bole/Screens/Home_Screen/Home.dart';
import 'package:earnify_bole/Screens/Home_Screen/Search.dart';
import 'package:earnify_bole/Screens/Home_Screen/Trending.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
    SearchScreen(),
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
        bottomNavigationBar:GNav(
            tabMargin: EdgeInsets.fromLTRB(7, 3, 7, 5),
            backgroundColor: Colors.white,
            color: Color(0xFF101B2D),
            iconSize: 25,
            activeColor: Colors.white,
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            tabBackgroundColor: Color(0xFF101B2D),
            tabs: const [
              GButton(
                padding: EdgeInsets.all(10),
                icon: Icons.home_rounded,
                text: 'Home',
              ),
              GButton(
                 padding: EdgeInsets.all(10),
                icon: Icons.local_fire_department,
                text: 'Trending',
              ),
              
              GButton(
                 padding: EdgeInsets.all(10),
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                 padding: EdgeInsets.all(10),
                icon: Icons.bookmark_outline,
                text: 'Booked',
              ),
              GButton(
                 padding: EdgeInsets.all(10),
                icon: Icons.person_2_outlined,
                text: 'Account',
              ),
            ],

        ));
  }
}
