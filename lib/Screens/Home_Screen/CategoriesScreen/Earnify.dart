import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/EarnifyController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';


class Earnify extends StatelessWidget {
  const Earnify({super.key});

  @override
  Widget build(BuildContext context) {
          RefreshController _refreshController = RefreshController(initialRefresh: false);
final controller = Get.put(EarnifyController());
final AllPostController = Get.find<AllController>();        
  void _onRefresh() async{
  controller.EarnifyData.value = [];
  await controller.fetchEarnifyData(1, 7);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreEarnifyData(controller.PageForMorData.value,7);
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
                        () => (controller.EarnifyData.isEmpty)
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
                                        controller.EarnifyData.length,
                                    itemBuilder: (context, index) {
                                      return GridCard(
                                        context,
                                        controller.EarnifyData[index],
                                        index,
                                        'Earnify',
                                      );
                                    },
                                  )
                                : Column(
                                    children: List.generate(
                                      controller.EarnifyData.length,
                                      (index) => BigCard(
                                          context,
                                          controller.EarnifyData[index],
                                          index,
                                          'Earnify'),
                                    ),
                                  ),
                      ), 

//     Obx(() => (controller.EarnifyData.isEmpty)?
                // Column(
                //   children: [
                //     shimmerEffect_2(context),
                //     SizedBox(height: 10,),
                //     shimmerEffect_2(context),
                //     SizedBox(height: 10,),
                //     shimmerEffect_2(context),
                //   ],
                // ):

//                 Column(
//                       children: List.generate(
//                       controller.EarnifyData.length,
//                       (index) => GestureDetector(
// onTap: ()=>Get.to(DetailScreen()),
// child: BigCard(context,controller.EarnifyData[index],index,'Earnify'),
//                       )
//                       ),
//                     ),
                        
//                     ),
                    
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