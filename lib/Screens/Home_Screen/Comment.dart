import 'package:earnify_bole/Controlers/CommentController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final controller = Get.find<CommentController>();
  @override
  void initState() {
    super.initState();
    controller.fetchCommentData();
  }
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    void _onRefresh() async {
      controller.CommentData.value = [];
      await controller.fetchMoreCommentData();
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await controller.fetchCommentData();
      _refreshController.loadComplete();
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close_rounded),
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Comments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )
              ],
            ),
            GestureDetector(
              onTap: ()=>{
                controller.CommentData.value = [],
                controller.fetchCommentData()
              },
              child: Icon(Icons.rotate_left_rounded),
            )
          ],
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: true,
        child: SingleChildScrollView(
            child: Obx(() => controller.CommentData.length==0?Center(
                child: controller.isLoading.value==true?Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                  shimmerEffect_2(context),
                    SizedBox(height: 10,),
                    shimmerEffect_2(context),
                    SizedBox(height: 10,),
                    shimmerEffect_2(context),
              ],
            ):Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Image.asset(
                  'assets/Comments.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
                const Text(
                  'There is no comment for this post',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      child: Text(
                        'Go Back',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )):Column(
              children: List.generate(
                                  controller.CommentData.length,
          (index) => Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5) ,
            
            width: MediaQuery.of(context).size.width-20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  child: Column(
                    children: [
                      Icon(Icons.person_outlined,size: 30,color: Colors.grey[500],),
                      Text('Admin',style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                      ),)
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child:  HtmlWidget(
                              controller.CommentData[index]['content']['rendered'],
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.grey[900]),
                            ),
                  ),
                )
              ],
            ),
          ),
            ))),
      ),
    ));
  }
}
