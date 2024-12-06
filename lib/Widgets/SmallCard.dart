import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
import 'package:flutter/material.dart';

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

Widget SmallCard(context,data){
  
  return  Container(
                    width:MediaQuery.of(context).size.width,
                    height:190,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow:[
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
                              flex: 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width-100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
Text(data['title']['rendered'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                    maxLines: 2,),
                                    SizedBox(height: 10,),
                                    GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: const Color.fromARGB(255, 238, 238, 238),
                                              width: 2,
                                            ),
                                            
                                          ),
                                    child: Text('Popular ',style: TextStyle(
                                          color: Colors.grey[700]
                                        ),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                width: 50,
                                height: 110,
child: imageEnhanced(data['jetpack_featured_media_url'])),
                            ),
                          ],
                        ),
                        SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.watch_later_outlined,color: Colors.grey[600],),
                                Text(DateFormatter.getRelativeTime(data['date']),style: TextStyle(
                              color: Colors.grey[700]
                            ),)
                              ],
                            ),
                            Icon(Icons.bookmark_border,color: Colors.grey[600],)
                          ],
                        )
                      ],
                    ),
                  );
}