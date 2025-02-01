import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
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

Widget SmallCard(context, data,index,search) {
  final storageData = GetStorage();


  
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
        "image": data['jetpack_featured_media_url'],
        'Link':data['link']
      });
    }
    storageData.write('Booked', Booked);
    isBookmarkedRx.value = !isBookmarkedRx.value;
  }






return Row(
  children: [
    SizedBox(width: 5,),
if(index==2)
      SizedBox(
height: 250,
        width: MediaQuery.of(context).size.width-180,
        child:  Stack(
          children: [
            
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Text('AD'),
              ),
            ),
            AdWidget(
            ad: AdMobHelper.getBannerAd(context,width: MediaQuery.of(context).size.width-180.toDouble(),height: 250)..load(),
              key: UniqueKey(),
            ),
          ],
        ),
      ),



Container(
  width: MediaQuery.of(context).size.width-180,
  height: 250,
  padding: EdgeInsets.all(4),
  
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(255, 218, 217, 217).withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(1, 2),
      ),
    ],
  ),
  child: Column(children: [
     Expanded(
              flex: 2,
              child: Stack(
                children: [
                  
                  SizedBox(
                      width: MediaQuery.of(context).size.width-150,
                      height: 250,
                      child: imageEnhanced(data['jetpack_featured_media_url'])),
                  Positioned(
                      top: 2,
                      right: 2,
                    child:  Obx(() => GestureDetector(  
                    onTap: () => BookMark(data),
                    child: isBookmarkedRx.value 
                      ? CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Color(0xFFA4634E),
                          child: Icon(Icons.bookmark_add_outlined, color: Colors.red,size: 25,)
                      )
                      :  CircleAvatar(
                        maxRadius: 13,
                          backgroundColor: Color(0xFFA4634E),
                          child: Icon(Icons.bookmark_add_outlined, color: Colors.white,size: 20,),
                      ),
                  ))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data['title']['rendered'],
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 15,
                      color: Color(0xFFA4634E),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFA4634E)),
                    )
                  ],
                ),

                Row(
                  children: [
                  
                    SizedBox(width: 5,),
                    Text(

                      DateFormatter.getRelativeTime(data['date']),
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFA4634E)),
                    )
                  ],
                ),

               Icon(
                      Icons.more_vert,
                      size: 15,
                      color: Colors.black,
                    ),  
       
              ],
            )

  ],),
  )
  ],
);
}
