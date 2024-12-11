import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

Widget BigCard(context, data, catagory) {
  final DetailControllers = Get.find<DetailController>();
  final bookMarkedController = Get.find<BookMarkedController>();
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
        "image": data['jetpack_featured_media_url']
      });
    }
    storageData.write('Booked', Booked);
    // Update the reactive state
    isBookmarkedRx.value = !isBookmarkedRx.value;
  }


  return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
height: 360,
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
      child: GestureDetector(
        onTap: () {
          DetailControllers.data.value = {
            'id': data['id'],
            'title':data['title']['rendered'],
            'content': data['content']['rendered'],
            'date': data['date'],
            'image': data['jetpack_featured_media_url']
          };
          Get.toNamed('/detail');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 180,
                child: imageEnhanced(data['jetpack_featured_media_url'])),
            SizedBox(
              height: 5,
            ),
            Text(
              catagory,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
       
            Text(
              data['title']['rendered'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
     
            Text(
              // Extract just the text from the first paragraph
              RegExp(r"<p>(.*?)</p>")
                      .firstMatch(data['content']['rendered'])
                      ?.group(1)
                      ?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                  '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
                height: 1.4,
              ),
            ),
            SizedBox(
height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                 Obx(() => GestureDetector(
    onTap: () => BookMark(data),
    child: isBookmarkedRx.value 
      ? Icon(Icons.bookmark, color: Colors.red)
      : Icon(Icons.bookmark_border),
  ))
              ],
            ),
          ],
        ),
      ));
}
