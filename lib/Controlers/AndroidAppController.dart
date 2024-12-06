import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class AndroiAppController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
    // 12 means Ai id
    RxInt endpoint = 6.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final AndroidAppData = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchAndroidAppData(Page.value,endpoint.value);
  }
  

Future<void> fetchMoreAndroidAppData(int page , int endpoint) async {
    PageForMorData++;
  print(PageForMorData);
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,PageForMorData.value);
    AndroidAppData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchAndroidAppData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
    AndroidAppData.value = result;
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}
