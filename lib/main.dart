import 'package:earnify_bole/DependencyInjection/ConnectivityDependencyInjection.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Screens/Home_Screen/InitialScreen.dart';
import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earnify_bole/Screens/Wlcome_Screen/Welcome_Screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
void main() async{
  await GetStorage.init();
  Get.put(WordPressApiService());
  runApp( MyApp());
  ConnectivityDependencyInjection.init();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final storageData = GetStorage();
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: (storageData.read('isFirstOpen') == null)?'/WelcomeScreen':'/initialScreen',
      getPages: [
        GetPage(name: '/WelcomeScreen', page: () => Welcome_Screen1()),
        GetPage(name: '/initialScreen', page: () => InitialHomeScreen()),
GetPage(name: '/detail', page: () => DetailScreen()),
      ],
    );
  }
}
