import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/AdController.dart';
import 'package:earnify_bole/DependencyInjection/ConnectivityDependencyInjection.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Screens/Home_Screen/InitialScreen.dart';
import 'package:earnify_bole/Screens/Home_Screen/Notification.dart';
import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:earnify_bole/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earnify_bole/Screens/Wlcome_Screen/Welcome_Screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// Handle background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await AdMobHelper.initialization();
   Get.put(AdManager()); 
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyA9Rp1oS_JB7WDVwmdvxQKkWnY1yTlQE84', // Get from google-services.json
      appId: '1:526662599856:android:a2d149003ac731a5732775', // Get from google-services.json
      messagingSenderId: '526662599856', // Get from google-services.json
      projectId: 'earnifybole', // Get from google-services.json
    ),
  );
  await GetStorage.init();
  

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final notificationService = NotificationService();
  await notificationService.initialize();

  Get.put(WordPressApiService());
  runApp( MyApp());
  ConnectivityDependencyInjection.init();
}



class MyApp extends StatelessWidget {
  MyApp({super.key});
  final storageData = GetStorage();
  

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
    GetPage(name: '/notification', page: () => NotificationScreen()),
      ],
    );
  }
}
