import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/SportController.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
class Sport extends StatelessWidget {
  const Sport({super.key});

  @override
  Widget build(BuildContext context) {
RefreshController _refreshController = RefreshController(initialRefresh: false);
final controller = Get.put(SportController());
final AllPostController = Get.find<AllController>(); 
  void _onRefresh() async{
  controller.SportData.value = [];
  await controller.fetchSportData(1, 11);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreSportData(controller.PageForMorData.value,11);
    _refreshController.loadComplete();
  }
    return   Scaffold(
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
        
                    
                    const SizedBox(height: 5,),
                    
                      Obx(
                        () => (controller.SportData.isEmpty)
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
                                        controller.SportData.length,
                                    itemBuilder: (context, index) {
                                      return GridCard(
                                        context,
                                        controller.SportData[index],
                                        index,
                                        'Sport',
                                      );
                                    },
                                  )
                                : Column(
                                    children: List.generate(
                                      controller.SportData.length,
                                      (index) => BigCard(
                                          context,
                                          controller.SportData[index],
                                          index,
                                          'Sport'),
                                    ),
                                  ),
                      ), 

                    
                    const SizedBox(height: 10,),
                    ],
                  )
                )
              ],
            ),
        ),
      ),
);
  }
}