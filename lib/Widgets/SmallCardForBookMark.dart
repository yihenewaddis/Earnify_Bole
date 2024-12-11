import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


   
Widget SmallCardForBookMark(context, data,index) {
  final bookMarkedController = Get.find<BookMarkedController>();
    final DetailControllers = Get.find<DetailController>();
  return GestureDetector(
     onTap: () {
          DetailControllers.data.value = {
            'id': data['id'],
            'title':data['title'],
            'content': data['content'],
            'date': data['date'],
'image': data['image']
          };
          Get.toNamed('/detail');
        },
    child: Container(
    width: MediaQuery.of(context).size.width,
height: 130,
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 15),
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
    child: Column(
      children: [
        Row(
          children: [
Expanded(
              flex: 2,
              child: SizedBox(
                  width: 50,
                  height: 110,
child: imageEnhanced(data['image'],)),
            ),
            
            SizedBox(
              width: 10,
            ),
       
            Expanded(
              flex: 4,
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
      data['title'],
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  Icons.watch_later_outlined,
                  color: Colors.grey[600],
                ),
                Text(
              DateFormatter.getRelativeTime(data['date']),
                  style: TextStyle(color: Colors.grey[700]),
                )
              ],
            ),
GestureDetector(
onTap: ()=>bookMarkedController.Remove(index),
                  child: Icon(
              Icons.remove_circle_outlined,
          color: Colors.red,
            ),
                ),
            
          ],
        )

                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    ));
}
