import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class TechController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
  
RxInt endpoint = 11.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final TechData = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchTechData(Page.value,endpoint.value);
  }
  

Future<void> fetchMoreTechData(int page, int endpoint) async {
    PageForMorData++;
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,PageForMorData.value);
TechData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchTechData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
   TechData.value = result;
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}

