
import 'package:earnify_bole/Controlers/BestWebsiteControler.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';


class BestWebsite extends StatelessWidget {
  const BestWebsite({super.key});

  @override
  Widget build(BuildContext context) {

    RefreshController _refreshController = RefreshController(initialRefresh: false);
    final controller = Get.put(BestWebsiteController());
        
  void _onRefresh() async{
  controller.BestWebsiteData.value = [];
  await controller.fetchBestWebsiteData(1, 13);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreBestWebsiteData(controller.PageForMorData.value,13);
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
                    const Text('Best Websites',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                            ),)
                          ],
                        ),
                    
                        GestureDetector(
      child: Icon(Icons.browser_updated_sharp,),
                        )
                      ],
                    ),
        
                    
                    const SizedBox(height: 15,),
                    
        Obx(() => (controller.BestWebsiteData.isEmpty)?
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
            controller.BestWebsiteData.length,
    (index) => GestureDetector(
      onTap: ()=>Get.to(DetailScreen()),


child: BigCard(context,controller.BestWebsiteData[index],'Website'),
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