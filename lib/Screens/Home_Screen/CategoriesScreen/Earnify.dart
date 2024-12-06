import 'package:earnify_bole/Controlers/EarnifyController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
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
        
  void _onRefresh() async{
  controller.EarnifyData.value = [];
  await controller.fetchEarnifyData(1, 5);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreEarnifyData(controller.PageForMorData.value,5);
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
                const Text('Earnify',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                            ),)
                          ],
                        ),
                        GestureDetector(
          child: Icon(Icons.collections_bookmark_outlined),
                        )
                      ],
                    ),
        
                    
                    const SizedBox(height: 15,),
                    
    Obx(() => (controller.EarnifyData.isEmpty)?
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
                      controller.EarnifyData.length,
                      (index) => GestureDetector(
onTap: ()=>Get.to(DetailScreen()),
child: BigCard(context,controller.EarnifyData[index],'Earnify'),
                      )
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