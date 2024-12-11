import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class CategoryController extends BaseController{


    RxInt Page = 1.obs;
    RxInt PageForMorData =1.obs;
  
RxInt endpoint = 10.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final CategoryList  = <dynamic>[].obs;
  

  @override
  void onInit(){
    super.onInit();
fetchCategoryData(0,0);
  }
  





Future<void> fetchCategoryData(int Page , int endpoint) async {
    try {
      startLoading();
final result = await _apiService.getApiData(0,0);
print('Catagory');
CategoryList.addAll(result);
print(result);
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }

  
}

