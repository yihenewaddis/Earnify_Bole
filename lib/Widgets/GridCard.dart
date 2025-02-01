import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/AiController.dart';
import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/AndroidAppController.dart';
import 'package:earnify_bole/Controlers/AndroidTipsControler.dart';
import 'package:earnify_bole/Controlers/BestWebsiteControler.dart';
import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Controlers/CryptoController.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Controlers/EarnifyController.dart';
import 'package:earnify_bole/Controlers/EarningAppController.dart';
import 'package:earnify_bole/Controlers/ForexController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Controlers/SportController.dart';
import 'package:earnify_bole/Controlers/Techcontroller.dart';
import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
    Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 218, 217, 217).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
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
else if(catagory == 'Android Apps'){
final androidAppController = Get.find<AndroiAppController>();
DetailControllers.Relateddata.value = androidAppController.AndroidAppData;
 }
else if(catagory == 'Android Tips'){
final androidTipsController = Get.find<AndroiTipsController>();
DetailControllers.Relateddata.value = androidTipsController.AndroidTipsData;
 }
else if(catagory == 'Website'){

final bestWebsiteController = Get.find<BestWebsiteController>();
DetailControllers.Relateddata.value = bestWebsiteController.BestWebsiteData;
 }
else if(catagory == 'Crypto'){
final cryptoController = Get.find<CryptoController>();
DetailControllers.Relateddata.value = cryptoController.CryptoData;
 }
 else if(catagory == 'Earnify'){

final earnifyController = Get.find<EarnifyController>();
DetailControllers.Relateddata.value = earnifyController.EarnifyData;
 }
else if(catagory == 'Earning App'){
final earningAppController = Get.find<EarningAppController>();
DetailControllers.Relateddata.value = earningAppController.EarningAppData;
 }
else if(catagory == 'Forex'){
final forexController = Get.find<ForexController>();
DetailControllers.Relateddata.value = forexController.ForexData;
 }
else if(catagory == 'Sport'){
final sportController = Get.find<SportController>();
DetailControllers.Relateddata.value = sportController.SportData;
 }
else if(catagory == 'Tech'){
final techController = Get.find<TechController>();
DetailControllers.Relateddata.value = techController.TechData;
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
                  child: imageEnhanced(data['jetpack_featured_media_url'])),
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
                  Icon(Icons.person, size: 15, color: Color(0xFFA4634E)),
                  SizedBox(width: 5,),
                      Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA4634E)),
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
                          color: Color(0xFFA4634E)),
                      )
                    ],
                  ),
                Obx(() => GestureDetector(
                onTap: () => BookMark(data),
                child: isBookmarkedRx.value 
                  ? CircleAvatar(
                    maxRadius: 13,
                    backgroundColor: Color(0xFFA4634E),
                    child: Icon(Icons.bookmark_add_outlined, color: Colors.red,size: 15,),
                  )
                  : CircleAvatar(
                    maxRadius: 13,
                      backgroundColor: Color(0xFFA4634E),
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
