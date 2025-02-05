import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import '../../../Controlers/AndroidAppController.dart';

class AndroidApps extends StatelessWidget {
  const AndroidApps({super.key});

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    final controller = Get.put(AndroiAppController());
    final AllPostController = Get.find<AllController>();
    void _onRefresh() async {
      controller.AndroidAppData.value = [];
      await controller.fetchAndroidAppData(1, 3);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await controller.fetchMoreAndroidAppData(
          controller.PageForMorData.value, 3);
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
                height: 5,
              ),

              // couresel page

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Obx(
                        () => (controller.AndroidAppData.isEmpty)
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
                                    itemCount: controller.AndroidAppData.length,
                                    itemBuilder: (context, index) {
                                      return GridCard(
                                        context,
                                        controller.AndroidAppData[index],
                                        index,
                                        'All',
                                      );
                                    },
                                  )
                                : Column(
                                    children: List.generate(
                                      controller.AndroidAppData.length,
                                      (index) => BigCard(
                                          context,
                                          controller.AndroidAppData[index],
                                          index,
                                          'All'),
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
