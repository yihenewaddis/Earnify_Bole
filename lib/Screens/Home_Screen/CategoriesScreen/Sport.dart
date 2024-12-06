import 'package:earnify_bole/Controlers/SportController.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
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

  void _onRefresh() async{
  controller.SportData.value = [];
  await controller.fetchSportData(1, 4);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreSportData(controller.PageForMorData.value,4);
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
            
              SizedBox(height: 15,),
            
              // couresel page
        

              
        
            
            SizedBox(height: 20,),
            
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
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            const SizedBox(width: 5,),
        const Text('Sport',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                            ),)
                          ],
                        ),
                        GestureDetector(
      child: Icon(Icons.sports),
                        )
                      ],
                    ),
        
                    
                    const SizedBox(height: 15,),
                    
Obx(() => (controller.SportData.isEmpty)?
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
              controller.SportData.length,
      (index) => BigCard(context,controller.SportData[index],'Sport')
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