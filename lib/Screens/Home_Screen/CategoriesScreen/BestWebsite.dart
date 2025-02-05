import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/BestWebsiteControler.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class BestWebsite extends StatelessWidget {
  const BestWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    final controller = Get.put(BestWebsiteController());
    final AllPostController = Get.find<AllController>();
    void _onRefresh() async {
      controller.BestWebsiteData.value = [];
      await controller.fetchBestWebsiteData(1, 5);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await controller.fetchMoreBestWebsiteData(
          controller.PageForMorData.value, 5);
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
                      

                      const SizedBox(
                        height: 5,
                      ),


                      Obx(
                        () => (controller.BestWebsiteData.isEmpty)
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
                                  shimmerEffect_2(context),
                                ],
                              )
                            : AllPostController.IsGrid.value
                                ? GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemCount:
                                        controller.BestWebsiteData.length,
                                    itemBuilder: (context, index) {
                                      return GridCard(
                                        context,
                                        controller.BestWebsiteData[index],
                                        index,
                                        'BestWebsite',
                                      );
                                    },
                                  )
                                : Column(
                                    children: List.generate(
                                      controller.BestWebsiteData.length,
                                      (index) => BigCard(
                                          context,
                                          controller.BestWebsiteData[index],
                                          index,
                                          'BestWebsite'),
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
