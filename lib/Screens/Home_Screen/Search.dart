import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Controlers/SearchController.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textController = TextEditingController();
  String searchText = '';
  final controller = Get.put(SearchControllers());
   final DetailControllers = Get.find<DetailController>();
   final Popularcontroller = Get.find<PopularController>();
  AdMobHelper adMobHelper = AdMobHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF101B2D),
        actions: [
          GestureDetector(
            onTap: ()=>{
              controller.fetchSearchData(_textController.text)
            },
            child: Icon(Icons.search,color: Colors.white,),
          ),
          SizedBox(width: 10,)
        ],
        title: TextField(
          autofocus: true,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          controller: _textController,
          decoration: InputDecoration(
          hintText: 'search...',
    border: InputBorder.none,
    contentPadding: EdgeInsets.zero,
   hintStyle: TextStyle(color: Colors.white)
   
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.SearchData.length == 0?Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: controller.IsSearching.value?[
            SizedBox(height: 10,),
            CircularProgressIndicator()
          ]:[
            SizedBox(height: 150,),
            Center(child:  Image.asset(
                  'assets/search.png',
                  width: 100,
                  height: 100,
                
                ),)
          ],
        ),
      ):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            
            children: List.generate(controller.SearchData.length, (index) => GestureDetector
            (
              onTap: () {
                                    adMobHelper.createInterstitialAd();
          DetailControllers.Relateddata.value = Popularcontroller.PopularData;
                                    DetailControllers.data.value = {
                                      'id': controller.SearchData[index]
                                          ['id'],
                                      'title':controller.SearchData[index]
                                          ['title']['rendered'],
                                      'content': controller.SearchData[index]
                                          ['content']['rendered'],
                                      'date':controller.SearchData[index]
                                          ['date'],
                                      'image':controller.SearchData[index]
                                          ['jetpack_featured_media_url'],
                                      "Link": controller.SearchData[index]['link']
                                    };
                                    Get.toNamed('/detail');
                                  },
              child: BigCard(context, controller.SearchData[index], index,'Popular'))),
          ),
        ),
      )),
    );
  }
}