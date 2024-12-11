import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class AllController extends BaseController{


    RxInt CurrentPageIndex = 0.obs;
    RxInt Page = 1.obs;
RxInt PageForMorData =1.obs;
    // 12 means Ai id
    RxInt endpoint = 0.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final AllData = <dynamic>[].obs;
    void changeCurrentIndex(int index){
      CurrentPageIndex.value = index;
    }

  @override
  void onInit(){
    super.onInit();
    fetchAllData(Page.value,endpoint.value);
  }
  

Future<void> fetchMoreAllData(int page , int endpoint) async {
    PageForMorData++;
  print(PageForMorData);
    try {
      startLoading();
    final result = await _apiService.getApiData(endpoint,PageForMorData.value);
      AllData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchAllData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
      AllData.value = result;
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}
