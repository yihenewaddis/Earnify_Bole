import 'package:earnify_bole/Controlers/AiController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Screens/Home_Screen/Trending.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
import 'package:earnify_bole/Widgets/SmallCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DateFormatter {
  static String getRelativeTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

class AI extends StatelessWidget {
  const AI({super.key});

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    final controller = Get.put(AiController());
    final Popularcontroller = Get.put(PopularController());

    void _onRefresh() async {
      controller.AiData.value = [];
      await controller.fetchAiData(1, 12);
      Popularcontroller.fetchPopularData(1, 16);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await controller.fetchMoreAiData(controller.PageForMorData.value, 12);

      _refreshController.loadComplete();
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),

              // couresel page
              Obx(() => (controller.AiData.isEmpty)
                  ? shimmerEffect_2(context)
                  : SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: PageView.builder(
                          onPageChanged: (index) {
                            controller.changeCurrentIndex(index);
                          },
                          itemCount: controller.AiData.length > 10
                              ? 10
                              : controller.AiData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                      child: GestureDetector(
                        
                        
onTap: ()=>Get.to(DetailScreen()),    
                        
                        
                    child: Stack(
                                children: [
                                  imageEnhanced(controller.AiData[index]
                                      ["jetpack_featured_media_url"]),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                controller.AiData[index]
                                                    ['title']['rendered'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.grey[100]),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                'Artificial Intelligence ',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.grey[100],
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.watch_later_outlined,
                                                  color: Colors.grey[100],
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  DateFormatter.getRelativeTime(
                                                      controller.AiData[index]
                                                          ['date']),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.grey[100]),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                  ),),
                            );
                          }),
                    )),

              SizedBox(
                height: 10,
              ),

              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0;
                        i <
                            ((controller.AiData.length > 10)
                                ? 10
                                : controller.AiData.length);
                        i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Obx(() => Container(
                              height: 6,
                              width:
                                  (controller.CurrentPageIndex == i) ? 12 : 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: (controller.CurrentPageIndex == i)
                                      ? Colors.black
                                      : Colors.grey[500],
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                      )
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 5,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Popular News',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Get.to(
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                TrendingScreen()),
                            child: Text(
                              'View All   ',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => (Popularcontroller.PopularData.isEmpty)
                            ? Column(
                                children: [
                                  shimmerEffect_2(context),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  shimmerEffect_2(context),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  shimmerEffect_2(context)
                                ],
                              )
                            : Column(
                                children: List.generate(
                                    (Popularcontroller.PopularData.length > 5)
                                        ? 5
                                        : Popularcontroller.PopularData.length,
                                    (index) => GestureDetector(


                                      onTap:()=>Get.to(DetailScreen()),



                                      child: SmallCard(context,
                                        Popularcontroller.PopularData[index]),
                                    )),
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 25,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Latest News',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => (controller.AiData.isEmpty)
                            ? shimmerEffect_2(context)
                            : Column(
                                children: List.generate(
                                    controller.AiData.length,
                                    (index) =>GestureDetector(
                                  onTap:()=> Get.to(DetailScreen()),
                                  
                                  child:  BigCard(context,
                                        controller.AiData[index], 'AI'),
                                    )),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
