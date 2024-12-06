import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class EarnifyController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
    // 12 means Ai id
RxInt endpoint = 5.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final EarnifyData = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchEarnifyData(Page.value,endpoint.value);
  }
  

Future<void> fetchMoreEarnifyData(int page, int endpoint) async {
    PageForMorData++;
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,PageForMorData.value);
EarnifyData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchEarnifyData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
EarnifyData.value = result;
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}

