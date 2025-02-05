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
fetchCategoryData();
  }
  





Future<void> fetchCategoryData() async {
    try {
      startLoading();
final result = await _apiService.getApiData(0,0);

CategoryList.value = result;
 print('--------------------------------');
      print(CategoryList);
      print('--------------------------------');
    } catch (e) {
      handleError(e.toString());
    } finally {
      stopLoading();
    }
  }

  
}

