import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          Text('Clear all',style: TextStyle(
            color: Colors.black
          ),),
          SizedBox(width: 20,)
        ],
      ),
      body: Center(
        child: Text('Notification screen'),
      ),
    );
  }
}