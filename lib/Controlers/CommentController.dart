import 'package:earnify_bole/Service/WordPressApiService.dart';
import 'package:get/get.dart';
import '../Controlers/BaseController.dart';
class CommentController extends BaseController{

    RxInt postId = 0.obs;
    RxInt CurrentPageIndex = 0.obs;
    RxInt Page = 1.obs;
    RxBool isLoading = false.obs;
RxInt PageForMorData =1.obs;
    // 12 means Ai id
    RxInt endpoint = 0.obs;
    final WordPressApiService _apiService = Get.find<WordPressApiService>();
final CommentData = <dynamic>[].obs;
    void changeCurrentIndex(int index){
      CurrentPageIndex.value = index;
    }




Future<void> fetchMoreCommentData() async {
    PageForMorData++;
  print(PageForMorData);
    try {
      startLoading();
    final result = await _apiService.getComments(postId.value,PageForMorData.value);
      CommentData.addAll(result);
    } catch (e) {
    handleErrorForMoreDta(e.toString());
    } finally {
      stopLoading();
    }
  }



Future<void> fetchCommentData() async {

    try {
      isLoading.value = true;
final result = await _apiService.getComments(postId.value,Page.value);
      CommentData.value = result;
      isLoading.value = false;
    print('*************************************************************************************');
    print(postId.value);
      print(CommentData);
    } catch (e) {
      isLoading.value = false;
      handleError(e.toString());
    } finally {
      isLoading.value = false;
      stopLoading();
    }
  }
}

