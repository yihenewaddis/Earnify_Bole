import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class EarningAppController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
  
RxInt endpoint = 8.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final EarningAppData = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchEarningAppData(Page.value,endpoint.value);
  }
  

Future<void> fetchMoreEarningAppData(int page, int endpoint) async {
    PageForMorData++;
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,PageForMorData.value);
EarningAppData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchEarningAppData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
EarningAppData.value = result;
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}

