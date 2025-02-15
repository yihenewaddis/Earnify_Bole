import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/AiController.dart';
import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

Widget GridCard(context, data,int index, catagory) {
  final DetailControllers = Get.find<DetailController>();
  final bookMarkedController = Get.find<BookMarkedController>();
  final storageData = GetStorage();
  
AdMobHelper adMobHelper = AdMobHelper();

  final isBookmarkedRx = false.obs;
bool isBookmarked() {
    List Booked = storageData.read('Booked') ?? [];
    return Booked.any((item) => item['id'] == data['id']);
  }
isBookmarkedRx.value = isBookmarked();


 void BookMark(data) {
    List Booked = storageData.read('Booked') ?? [];

    if (isBookmarked()) {
      Booked.removeWhere((item) => item['id'] == data['id']);
    } else {
      Booked.add({
        'id': data['id'],
        'title': data['title']['rendered'],
        'content': data['content']['rendered'],
        "date": data['date'],
        "image": data['jetpack_featured_media_url']
      });
    }
    storageData.write('Booked', Booked);
    
    isBookmarkedRx.value = !isBookmarkedRx.value;
  }

return Column(
  children: [
//     (index % 3 == 0 && index !=0)?

//       SizedBox(

//       width: MediaQuery.of(context).size.width,
// height: 200,
//         child: Stack(
//           children: [
//             SizedBox(height: 10,),
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Center(
//                 child: Text('AD'),
//               ),
//             ),
//             AdWidget(
//             ad: AdMobHelper.getBannerAd(context,width: MediaQuery.of(context).size.width-10,height: 200)..load(),
//               key: UniqueKey(),
//             ),
//           ],
//         ),
//       ):
    Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF101B2D).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 0.5,
            offset: Offset(1, 1),
          ),
        ],
      ),
  child:GestureDetector(
onTap: () async{
 adMobHelper.createInterstitialAd();
 if(catagory=='All'){
final AllControllers= Get.find<AllController>();
DetailControllers.Relateddata.value = AllControllers.AllData;
}
else if(catagory == 'Trending'){
final popularController = Get.find<PopularController>();
DetailControllers.Relateddata.value = popularController.PopularData;
 }
else if(catagory == 'AI'){
final aiController = Get.find<AiController>();
DetailControllers.Relateddata.value = aiController.AiData;
 }
  
          DetailControllers.data.value = {
            'id': data['id'],
            'title':data['title']['rendered'],
            'content': data['content']['rendered'],
            'date': data['date'],
            'image': data['jetpack_featured_media_url'],
            'Link':data['link']
          };
          Get.toNamed('/detail');
          

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: imageEnhanced(data['jetpack_featured_media_url'])
                  
                  ),
            ),
            SizedBox(
              width: 5,
            ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                data['title']['rendered'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
      
              SizedBox(
                height: 5,
              ),
              Row(
                    
                    children: [
                  Icon(Icons.person, size: 15, color: Color(0xFF101B2D)),
                  SizedBox(width: 5,),
                      Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF101B2D)),
                      )
                    ],
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormatter.getRelativeTime(data['date']),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF101B2D)),
                      )
                    ],
                  ),
                Obx(() => GestureDetector(
                onTap: () => BookMark(data),
                child: isBookmarkedRx.value 
                  ? CircleAvatar(
                    maxRadius: 13,
                    backgroundColor: Color(0xFF101B2D),
                    child: Icon(Icons.bookmark_add_outlined, color: Colors.red,size: 15,),
                  )
                  : CircleAvatar(
                    maxRadius: 13,
                      backgroundColor: Color(0xFF101B2D),
                      child: Icon(Icons.bookmark_add_outlined, color: Colors.white,size: 18,),
                  ),
              ))
                ],
              ),
              ],
            ),
          )
            
          ],
        ),
      ))
  ],
);
}
