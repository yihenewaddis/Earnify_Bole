import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = 
  FlutterLocalNotificationsPlugin();
 final GetStorage _storage = GetStorage();
 
  void _storeNotification(RemoteMessage message) {
    try {
      
  List notifications = (_storage.read('notifications') ?? []);
      
      
      Map<String, dynamic> notificationData = {
        'id': message.messageId,
        'title': message.notification?.title,
        'body': message.notification?.body,
        'data': message.data,
        'timestamp': DateTime.now().toIso8601String(),
        'isRead': false,
      };

     
      notifications.insert(0, notificationData);
      
      // Optionally limit the number of stored notifications (e.g., keep last 50)
      if (notifications.length > 50) {
        notifications = notifications.sublist(0, 50);
      }

      // Save to storage
      _storage.write('notifications', notifications);
      
      print('Notification stored: ${notificationData['title']}');
    } catch (e) {
      print('Error storing notification: $e');
    }
  }
  Future<void> initialize() async {
    // Request permission
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        
    const InitializationSettings initializationSettings = 
        InitializationSettings(android: initializationSettingsAndroid);
        
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
        _handleNotificationTap(details.payload);
      },
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
    
       // Handle background/terminated state notification taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });
        // Handle initial notification when app was terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Get FCM token
    String? token = await _fcm.getToken();
    print('FCM Token: $token');  // Save this token to your backend
  }
void _handleMessage(RemoteMessage message) {
     Future.delayed(Duration(milliseconds: 100), () {
      try {
        final String? id = message.data['id'];
    Get.toNamed('/initialScreen', arguments: {'id': id});
      } catch (e) {
        print('Error navigating: $e');
      }
    });
  }

 void _handleNotificationTap(String? payload) {
    if (payload != null) {
      print('Received payload: $payload'); // Debug print
      
      try {
        // Improved payload parsing
        String cleanPayload = payload.replaceAll('{', '').replaceAll('}', '');
        Map<String, String> data = {};
        
        cleanPayload.split(',').forEach((element) {
          var parts = element.split(':');
          if (parts.length == 2) {
            data[parts[0].trim()] = parts[1].trim();
          }
        });

        final String? id = data['id'];
        
        // Simplified to always route to notification screen
    Get.toNamed('/initialScreen', arguments: {'id': id});
        
      } catch (e) {
        print('Error parsing notification payload: $e');
      }
    }
}

  Future<void> _showNotification(RemoteMessage message) async {

    _storeNotification(message);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }
}