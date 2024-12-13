import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends GetxController{
    final GetStorage _storage = GetStorage();
RxList notifications = [].obs;
RxMap ClickedToRead = {}.obs;
 RxInt get unreadCount => notifications
      .where((notification) => notification['isRead'] != true)
      .length
      .obs;

      
  void getStoredNotifications() {
    notifications.value = (_storage.read('notifications') ?? []).cast<Map<String, dynamic>>();
    print("this is notification");
print(notifications);
  }

  @override
  void onInit(){
    super.onInit();
    getStoredNotifications();
  }

   void Remove(index) {
// Check if index is valid
  final List newList = List.from(notifications);
      newList.removeAt(index);
  notifications.value = newList;
_storage.write('notifications', notifications.toList());
 
  }

void clearAll(){
notifications.value = [];
_storage.remove('notifications');
  }

void ChangeReadStatus(index){
final List newList = List.from(notifications);
  newList[index]['isRead'] = true;
  notifications.value = newList;
  _storage.write('notifications', notifications.toList());
}

}