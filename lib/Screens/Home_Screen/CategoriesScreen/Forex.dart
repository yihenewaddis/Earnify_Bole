import 'package:earnify_bole/Controlers/ForexController.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
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

  void _onRefresh() async{
  controller.ForexData.value = [];
  await controller.fetchForexData(1, 3);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreForexData(controller.PageForMorData.value,3);
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
      //       const Text('Forex',style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.w700
      //                       ),)
      //                     ],
      //                   ),
      //                   GestureDetector(
      // child: Icon(Icons.bar_chart_rounded),
      //                   )
      //                 ],
      //               ),
        
                    
                    const SizedBox(height: 15,),
                    
Obx(() => (controller.ForexData.isEmpty)?
                Column(
                  children: [
                    shimmerEffect_2(context),
                    SizedBox(height: 10,),
                    shimmerEffect_2(context),
                    SizedBox(height: 10,),
                    shimmerEffect_2(context),
                  ],
                ):

                Column(
                      children: List.generate(
              controller.ForexData.length,
          (index) => BigCard(context,controller.ForexData[index],'Forex')
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