import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class PopularController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
  
RxInt endpoint = 16.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final PopularData = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchPopularData(Page.value,endpoint.value);
  }
  

Future<void> fetchMorePopularData(int page, int endpoint) async {
    PageForMorData++;
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,PageForMorData.value);
PopularData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchPopularData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
   PopularData.value = result;
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}

