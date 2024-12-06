import 'package:earnify_bole/Controlers/Internet_Connection_Checker.dart';
import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
class ConnectivityDependencyInjection{
  static void init(){
    Get.put<InternetConnectionControler>(InternetConnectionControler(),permanent: true);
  }
}