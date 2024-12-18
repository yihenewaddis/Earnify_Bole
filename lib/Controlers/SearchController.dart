import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class SearchControllers extends BaseController{


    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final SearchData = <dynamic>[].obs;
RxBool IsSearching = false.obs; 
  

Future<void> fetchSearchData(String text ) async {
  IsSearching.value = true;
    try {
      
final result = await _apiService.getSearch(text);
IsSearching.value = false;
   SearchData.value = result;
   print('SearchData');
   print(SearchData);
    } catch (e) {
      IsSearching.value = false;
      handleError(e.toString());
    } finally {
      IsSearching.value = false;
      stopLoading();
    }
  }
}

