import 'package:get/get.dart';

class DetailController extends GetxController{
RxList Relateddata = [].obs;
RxMap<String, dynamic> data =  <String, dynamic>{
'id':0,
'title': '',
'content':'',
"date":'',
"image":'',
"Link":''
}.obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // adMobHelper.createInterstitialAd();
  }
}