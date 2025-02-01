import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
import 'package:get_storage/get_storage.dart';
class AllController extends BaseController{


    RxInt CurrentPageIndex = 0.obs;
    RxInt Page = 1.obs;
    RxBool IsGrid = false.obs;
    RxInt PageForMorData =1.obs;
    // 12 means Ai id
    RxInt endpoint = 0.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final AllData = <dynamic>[].obs;
    void changeCurrentIndex(int index){
      CurrentPageIndex.value = index;
    }


    void ChangeLayout(){
      IsGrid.value = !IsGrid.value;
    }


  @override
  void onInit(){
    super.onInit();
     final storage = GetStorage();
  storage.write('isFirstOpen', true);
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

