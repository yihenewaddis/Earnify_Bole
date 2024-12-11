import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import '../../../Controlers/AndroidAppController.dart';

class AndroidApps extends StatelessWidget {
  const AndroidApps({super.key});

  @override
  Widget build(BuildContext context) {
    
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    final controller = Get.put(AndroiAppController());
        
  void _onRefresh() async{
    controller.AndroidAppData.value = [];
  await controller.fetchAndroidAppData(1, 6);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreAndroidAppData(controller.PageForMorData.value,12);
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
        

              
        
            
            
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
//                       Row(     
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                           Container(
//                               width: 5, 
//                               height: 25,
//                               decoration: BoxDecoration(
                                
//                                 color: Colors.black, 
//                                 borderRadius: BorderRadius.circular(10)
//                               ),
//                             ),
//                             const SizedBox(width: 5,),
//                             const Text('Android Apps',style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700
//                             ),)
//                           ],
//                         ),
                    
//                         GestureDetector(
//               child: Icon(Icons.android_sharp),
//                         )
//                       ],
// ),
        
                    
                Obx(() => (controller.AndroidAppData.isEmpty)?
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
                    controller.AndroidAppData.length,
                  (index) => GestureDetector(


onTap: ()=>Get.to(DetailScreen()),

                    child: BigCard(context,controller.AndroidAppData[index],'Android Apps'),
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