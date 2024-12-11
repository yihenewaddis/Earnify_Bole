import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookMarkedController extends GetxController{
  final Booked = <dynamic>[].obs;
final storageData = GetStorage();
  @override
void onInit() {
    Booked.value = storageData.read('Booked') ?? [];
    print('object');
  }
void Refresh(){
  Booked.value = storageData.read('Booked') ?? [];
}
  void Remove(index) {
    if (index >= 0 && index < Booked.length) {  // Check if index is valid
      final List newList = List.from(Booked);
      newList.removeAt(index);
      Booked.value = newList;
      storageData.write('Booked', Booked.toList());
    }
  }
  void clearAll(){
    Booked.value = [];
    storageData.remove('Booked');
  }

  
}