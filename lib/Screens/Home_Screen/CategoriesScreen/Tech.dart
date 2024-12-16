import 'package:earnify_bole/Controlers/SportController.dart';
import 'package:earnify_bole/Controlers/Techcontroller.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class Tech extends StatelessWidget {
  const Tech({super.key});

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController = RefreshController(initialRefresh: false);
final controller = Get.put(TechController());

  void _onRefresh() async{
  controller. TechData.value = [];
  await controller.fetchTechData(1, 11);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreTechData(controller.PageForMorData.value,11);
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
      //   const Text('Tech',style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.w700
      //                       ),)
      //                     ],
      //                   ),
      //                   GestureDetector(
      // child: Icon(Icons.computer),
      //                   )
      //                 ],
      //               ),
        
                    
                    const SizedBox(height: 15,),
                    
Obx(() => (controller.TechData.isEmpty)?
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
              controller.TechData.length,
  (index) => BigCard(context,controller.TechData[index],index,'Tech')
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