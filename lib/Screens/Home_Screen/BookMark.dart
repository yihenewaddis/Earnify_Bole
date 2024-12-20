import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Widgets/SmallCardForBookMark.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
class DateFormatter {
  static String getRelativeTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {

    
    final bookMarkedController = Get.find<BookMarkedController>();
    bookMarkedController.Refresh();
    return Scaffold(
      appBar: AppBar(
title: Text('BookMarked',style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold
),),
actions: [
 GestureDetector(
onTap: ()=>bookMarkedController.clearAll(),
  child:  Text('Clear All'),
 ),
  SizedBox(width: 10,)
],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
padding: EdgeInsets.only(top: 20),
child: Stack(
  children: [
    Obx(()=> ListView.builder(
      itemCount: bookMarkedController.Booked.length,
    itemBuilder: (context,index){
    return SmallCardForBookMark(context,bookMarkedController.Booked[index],index);}
    ,
          ),
    ),
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
)));
  }
}