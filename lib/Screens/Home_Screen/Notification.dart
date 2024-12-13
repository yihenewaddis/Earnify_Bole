import 'package:earnify_bole/Controlers/NotificationController.dart';
import 'package:earnify_bole/Screens/Home_Screen/NotificationDetail.dart';
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


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
final NotificationController _NotificationController = Get.put(NotificationController());
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 254, 255, 252),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text('Notifications',style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
    
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => {_NotificationController.clearAll()},
            child:const Text('Clear all',style: TextStyle(
            color: Colors.black
      ),),
          ),
          SizedBox(width: 20,)
        ],
      ),
body: Obx(() => ListView.builder(itemCount:_NotificationController.notifications.length,itemBuilder:(context,index){
return  GestureDetector(
  onTap: (){
_NotificationController.ClickedToRead.value = _NotificationController.notifications[index];
_NotificationController.ChangeReadStatus(index);
Get.to(NotificationDetail());
  },
  child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
child: Column(
    children: [
  SizedBox(height:10,),
      Container(
    padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), // Optional: if you want rounded corners
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2), // Shadow color
        spreadRadius: 1, // How much the shadow spreads
        blurRadius: 5, // How blurry the shadow is
        offset: Offset(0, 2), // Changes position of shadow (horizontal, vertical)
      ),
    ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                     Expanded(  // Wrap Text with Expanded to give it available width
              child: Text(_NotificationController.notifications[index]['title']??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              
          ),  // Optional: adjust font size as needed
                  ),
                ),
            SizedBox(width: 10,),
          Obx(() => Icon(Icons.circle,color: _NotificationController.notifications[index]['isRead']?Colors.black:Colors.red,))
              ],
            ),
              Expanded( 
                flex: 1, // Wrap Text with Expanded to give it available width
          child: Text(_NotificationController.notifications[index]['body']??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,  // Optional: adjust font size as needed
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(
                    children: [
                  Icon(Icons.watch_later_outlined,color: Colors.grey[500]),
                SizedBox(width: 10,),
        Text(DateFormatter.getRelativeTime(_NotificationController.notifications[index]['timestamp']),style: TextStyle(
                  color: Colors.grey[500]
                ),)
                    ],
                  ),
              GestureDetector(
            onTap: ()=>_NotificationController.Remove(index),
            child: Icon(Icons.close),
              )
                  ],
                )
          ],
        ),
      )
    ],

)),
);
  })),
    );
  }
}