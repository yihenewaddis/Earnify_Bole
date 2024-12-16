import 'package:earnify_bole/Controlers/AndroidTipsControler.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class AndroidTips extends StatelessWidget {
  const AndroidTips({super.key});

  @override
  Widget build(BuildContext context) {
RefreshController _refreshController = RefreshController(initialRefresh: false);
final controller = Get.put(AndroiTipsController());
        
  void _onRefresh() async{
  controller.AndroidTipsData.value = [];
  await controller.fetchAndroidTipData(1, 7);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreAndroidTipData(controller.PageForMorData.value,7);
    _refreshController.loadComplete();
  }
    print('Android Tips');
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
            
              
              
            
              // couresel page
        

              
        
            
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
              //         Row(     
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Row(
              //             children: [
              //             Container(
              //                 width: 5, 
              //                 height: 25,
              //                 decoration: BoxDecoration(
                                
              //                   color: Colors.black, 
              //                   borderRadius: BorderRadius.circular(10)
              //                 ),
              //               ),
              //               const SizedBox(width: 5,),
              //           const Text('Android Tips',style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w700
              //               ),)
              //             ],
              //           ),
                    
              //           GestureDetector(
              // child: Icon(Icons.tips_and_updates,color: Color.fromARGB(255, 245, 188, 17),),
              //           )
              //         ],
              //       ),
        
                 
        
                    
                    const SizedBox(height: 15,),
                    
            Obx(() => (controller.AndroidTipsData.isEmpty)?
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
                controller.AndroidTipsData.length,
            (index) => GestureDetector(


onTap: ()=>Get.to(DetailScreen()),


      child: BigCard(context,controller.AndroidTipsData[index],index,'Android Tips'),
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