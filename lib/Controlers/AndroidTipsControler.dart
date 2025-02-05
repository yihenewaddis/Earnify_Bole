import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class AndroiTipsController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
    // 12 means Ai id
RxInt endpoint = 4.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final AndroidTipsData = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchAndroidTipData(Page.value,endpoint.value);
  }
  

Future<void> fetchMoreAndroidTipData(int page, int endpoint) async {
    PageForMorData++;
  print(PageForMorData);
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,PageForMorData.value);
AndroidTipsData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchAndroidTipData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
AndroidTipsData.value = result;
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}

