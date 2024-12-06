import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class ForexController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
  
RxInt endpoint = 3.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final ForexData = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchForexData(Page.value,endpoint.value);
  }
  

Future<void> fetchMoreForexData(int page, int endpoint) async {
    PageForMorData++;
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,PageForMorData.value);
ForexData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchForexData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
   ForexData.value = result;
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}

