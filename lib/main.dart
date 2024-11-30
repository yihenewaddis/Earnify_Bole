import 'package:earnify_bole/Screens/Home_Screen/InitialScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earnify_bole/Screens/Wlcome_Screen/Welcome_Screen.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme), // Apply Poppins globally
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/WelcomeScreen',
      getPages: [
        GetPage(name: '/WelcomeScreen', page: () => Welcome_Screen1()),
        GetPage(name: '/initialScreen', page: () => InitialHomeScreen()),
        
      ],
    );
  }
}
