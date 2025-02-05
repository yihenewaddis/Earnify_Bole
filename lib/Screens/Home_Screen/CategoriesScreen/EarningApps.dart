import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/EarningAppController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class EarningApps extends StatelessWidget {
  const EarningApps({super.key});

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController = RefreshController(initialRefresh: false);
final controller = Get.put(EarningAppController());
final AllPostController = Get.find<AllController>(); 
  void _onRefresh() async{
  controller.EarningAppData.value = [];
  await controller.fetchEarningAppData(1, 8);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreEarningAppData(controller.PageForMorData.value,8);
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
      //                 Row(     
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Row(
      //                     children: [
      //                     Container(
      //                         width: 5, 
      //                         height: 25,
      //                         decoration: BoxDecoration(
                                
      //                           color: Colors.black, 
      //                           borderRadius: BorderRadius.circular(10)
      //                         ),
      //                       ),
      //                       const SizedBox(width: 5,),
      //           const Text('EarningApp',style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.w700
      //                       ),)
      //                     ],
      //                   ),
      //                   GestureDetector(
      // child: Icon(Icons.collections_bookmark_outlined),
      //                   )
      //                 ],
      //               ),
        
                    
                    const SizedBox(height: 5,),
                    Obx(
                        () => (controller.EarningAppData.isEmpty)
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
                                        controller.EarningAppData.length,
                                    itemBuilder: (context, index) {
                                      return GridCard(
                                        context,
                                        controller.EarningAppData[index],
                                        index,
                                        'Earning App',
                                      );
                                    },
                                  )
                                : Column(
                                    children: List.generate(
                                      controller.EarningAppData.length,
                                      (index) => BigCard(
                                          context,
                                          controller.EarningAppData[index],
                                          index,
                                          'Earning App'),
                                    ),
                                  ),
                      ), 

// Obx(() => (controller.EarningAppData.isEmpty)?
//                 Column(
//                   children: [
//                     shimmerEffect_2(context),
//                     SizedBox(height: 10,),
//                     shimmerEffect_2(context),
//                     SizedBox(height: 10,),
//                     shimmerEffect_2(context),
//                   ],
//                 ):

//                 Column(
//                       children: List.generate(
//                   controller.EarningAppData.length,
//               (index) => GestureDetector(
//             onTap: ()=>Get.to(DetailScreen()),
// child: BigCard(context,controller.EarningAppData[index],index,'Earning App'),
//               )
//                       ),
//                     ),
                        
//                     ),
                    
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