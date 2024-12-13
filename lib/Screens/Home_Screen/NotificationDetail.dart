import 'package:earnify_bole/Controlers/NotificationController.dart';
import 'package:flutter/foundation.dart';
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

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({super.key});

  @override
  Widget build(BuildContext context) {
final _NotificationController = Get.find<NotificationController>();
    return Scaffold(
  appBar: AppBar(
    title: Text("Notification Detail"),
  ),
body: SingleChildScrollView(
child: Padding(
padding:     EdgeInsets.all(10),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

 Text(_NotificationController.ClickedToRead['title']??'',
  textAlign: TextAlign.left, 
                    style:const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  
              
          ),  // Optional: adjust font size as needed
              ),
              SizedBox(height: 5,),
Container(
  height: 2,
  width: MediaQuery.of(context).size.width,
  color: Colors.grey[500],
),
Text(_NotificationController.ClickedToRead['body']??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,  // Optional: adjust font size as needed
                  ),
        SizedBox(height: 5,),        
      Text(DateFormatter.getRelativeTime(_NotificationController.ClickedToRead['timestamp']),style: TextStyle(
                  color: Colors.grey[500]
                ),)
],


),)));
 
  }
}


// Column(
//     children: [
//   SizedBox(height:10,),
//       Container(
//     padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10), // Optional: if you want rounded corners
//         ),
//         width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height-10,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                      Expanded(  // Wrap Text with Expanded to give it available width
  // child: Text(_NotificationController.ClickedToRead['title'],
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style:const TextStyle(
  //                 fontSize: 17,
  //                 fontWeight: FontWeight.bold
              
  //         ),  // Optional: adjust font size as needed
  //                 ),
//                 ),
           
         
//               ],
//             ),
//               Expanded( 
//                 flex: 1, // Wrap Text with Expanded to give it available width
      // child: Text(_NotificationController.ClickedToRead['body'],
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //               style: TextStyle(fontSize: 16),
      //               textAlign: TextAlign.left,  // Optional: adjust font size as needed
      //             ),
      //           ),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                   Row(
//                     children: [
//                       Icon(Icons.watch_later_outlined,color: Colors.grey[500]),
//                 SizedBox(width: 10,),
    // Text(DateFormatter.getRelativeTime(_NotificationController.ClickedToRead['timestamp']),style: TextStyle(
    //               color: Colors.grey[500]
    //             ),)
//                     ],
//                   ),
//                   ],
//                 )
//           ],
//         ),
//       )
//     ],

// )