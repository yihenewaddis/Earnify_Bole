import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class InitialHomeScreen extends StatefulWidget {
  const InitialHomeScreen({super.key});

  @override
  State<InitialHomeScreen> createState() => _InitialHomeScreenState();
}

class _InitialHomeScreenState extends State<InitialHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Earnify Bole",style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),),
        leading: Container(
          child: Icon(Icons.menu,size: 30,),
        ),
        actions: [
          GestureDetector(child: Icon(Icons.search,size: 30,weight: 10,)),
          SizedBox(width: 15,),
          GestureDetector(child: Icon(Icons.notifications_none,size: 30,)),
          SizedBox(width: 15,),
        ],
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
        child: GNav(
          color: Colors.grey[600],
          iconSize: 25,
          activeColor: Colors.black,
          selectedIndex: 0,
          onTabChange: (index){
            print("index");
            print(index);
          },
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          gap: 8,
          tabBackgroundColor: Color.fromARGB(255, 236, 235, 235),
          tabs: [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
              
              ),
        
            GButton(
              icon:Icons.fireplace_sharp,
              text: 'Trending',
            ),
            GButton(
              icon: Icons.bookmark_border,
              text: 'Booked',
              ),
            GButton(
              icon: Icons.person_2_outlined,
              text: 'Account',
              ),
          ],
        ),
      )
      
      
    );
  }
}