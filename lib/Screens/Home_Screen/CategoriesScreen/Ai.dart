import 'package:earnify_bole/Controlers/AiController.dart';
import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Screens/Home_Screen/Trending.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
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
    final AllPostController = Get.find<AllController>();
    void _onRefresh() async {
      controller.AiData.value = [];
      await controller.fetchAiData(1, 12);
// await Popularcontroller.fetchPopularData(1, 16);
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

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
      
                      SizedBox(
    height: 15,
                      ),

                      
                      Obx(
                        () => (controller.AiData.isEmpty)
                            ?                 Column(
                  children: [
                    shimmerEffect_2(context),
                    SizedBox(height: 10,),
                    shimmerEffect_2(context),
                    SizedBox(height: 10,),
                    shimmerEffect_2(context),
                  ],
                ):  Obx(
                        () => (controller.AiData.isEmpty)
                            ? shimmerEffect_2(context)
                            : AllPostController.IsGrid.value? GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: controller.AiData.length,
                            itemBuilder: (context, index) {
                              return GridCard(
                                context,
                                controller.AiData[index],
                                index,
                                'AI',
                              );
                            },
                          ):
                            Column(
                                children: List.generate(
                                controller.AiData.length,
                              (index) =>BigCard(context,
                          controller.AiData[index],index ,'AI'),
                                ),
                              ),
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
