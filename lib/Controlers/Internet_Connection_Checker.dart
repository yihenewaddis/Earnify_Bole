import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class InternetConnectionControler extends GetxController{
  RxBool isConnected = false.obs;
  RxBool IsLoading = true.obs;
  @override
  void onInit(){
    super.onInit();
    checkInternet();
  }
  Future<void> checkInternet() async{
    isConnected.value =  await InternetConnectionChecker().hasConnection;
    IsLoading.value = false;
  }
  
}