import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class CryptoController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
    // 12 means Ai id
RxInt endpoint = 2.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final CryptoData = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchCryptoData(Page.value,endpoint.value);
  }
  

Future<void> fetchMoreCryptoData(int page, int endpoint) async {
    PageForMorData++;
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,PageForMorData.value);
CryptoData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchCryptoData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(endpoint,Page);
CryptoData.value = result;
print('data');
print(CryptoData);
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }
}

