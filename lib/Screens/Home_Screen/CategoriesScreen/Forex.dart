import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/ForexController.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class Forex extends StatelessWidget {
  const Forex({super.key});

  @override
  Widget build(BuildContext context) {

RefreshController _refreshController = RefreshController(initialRefresh: false);
final controller = Get.put(ForexController());
final AllPostController = Get.find<AllController>(); 
  void _onRefresh() async{
  controller.ForexData.value = [];
  await controller.fetchForexData(1, 9);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreForexData(controller.PageForMorData.value,9);
    _refreshController.loadComplete();
  }

    return  Scaffold(
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
                        () => (controller.ForexData.isEmpty)
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
                                        controller.ForexData.length,
                                    itemBuilder: (context, index) {
                                      return GridCard(
                                        context,
                                        controller.ForexData[index],
                                        index,
                                        'Forex',
                                      );
                                    },
                                  )
                                : Column(
                                    children: List.generate(
                                      controller.ForexData.length,
                                      (index) => BigCard(
                                          context,
                                          controller.ForexData[index],
                                          index,
                                          'Forex'),
                                    ),
                                  ),
                      ),                 

                    
                    const SizedBox(height: 20,),
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