import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class AiController extends BaseController{


    RxInt CurrentPageIndex = 0.obs;
    RxInt Page = 1.obs;
RxInt PageForMorData =1.obs;
    // 12 means Ai id
    RxInt endpoint = 2.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
    final AiData = <dynamic>[].obs;
    void changeCurrentIndex(int index){
      CurrentPageIndex.value = index;
    }

  @override
  void onInit(){
    super.onInit();
    fetchAiData(Page.value);
  }

void ChangeEndPoint( id){
endpoint.value = id;
fetchAiData(Page.value);
}

Future<void> fetchMoreAiData(int page ) async {
    PageForMorData++;
  print(PageForMorData);
    try {
      startLoading();
    final result = await _apiService.getApiData(endpoint.value,PageForMorData.value);
      AiData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



  Future<void> fetchAiData(int Page) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint.value,Page);
      AiData.value = result;
      print('object');
      print(AiData);
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}

