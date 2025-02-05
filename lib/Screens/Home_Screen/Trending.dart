import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
        RefreshController _refreshController = RefreshController(initialRefresh: false);
final controller = Get.find<PopularController>();
    final AllPostController = Get.find<AllController>();
  void _onRefresh() async{
controller.PopularData.value = [];
await controller.fetchPopularData(1,10);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMorePopularData(controller.PageForMorData.value,10);
    _refreshController.loadComplete();
  }
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF101B2D),
        title:Row(     
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                          Container(
                              width: 5, 
                              height: 25,
                              decoration: BoxDecoration(
                                
                                color: Colors.white, 
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            const SizedBox(width: 5,),
const Text('Trending',style: TextStyle(
  color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                            ),)
                          ],
                        ),
        GestureDetector(
                            onTap: () => AllPostController.ChangeLayout(),
                            child: Obx(() => Icon(
                              (AllPostController.IsGrid.value)
                                  ? Icons.grid_view
                                  : Icons.line_style_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                          ),
                      ],
                    ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SmartRefresher(
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
                          
            
                        
                        const SizedBox(height: 5,),
              Obx(
                        () => (controller.PopularData.isEmpty)
                            ? Column(
                  children: [
                    shimmerEffect_2(context),
                    SizedBox(height: 10,),
                    shimmerEffect_2(context),
                    SizedBox(height: 10,),
                    shimmerEffect_2(context),
                  ],
                )
                            : AllPostController.IsGrid.value? GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: controller.PopularData.length,
                            itemBuilder: (context, index) {
                              return GridCard(
                                context,
                                controller.PopularData[index],
                                index,
                                'Popular',
                              );
                            },
                          ):
                            Column(
                                children: List.generate(
                                controller.PopularData.length,
                              (index) =>BigCard(context,
                         controller.PopularData[index],index ,'Popular'),
                                ),
                              ),
                      ),                 
          // Obx(() => (controller.PopularData.isEmpty)?
          //           Column(
          //             children: [
          // shimmerEffect_2(context),
          //               SizedBox(height: 10,),
          //               shimmerEffect_2(context),
          //               SizedBox(height: 10,),
          //               shimmerEffect_2(context),
          //               SizedBox(height: 10,),
          //               shimmerEffect_2(context),
          //             ],
          //           ):
          
          //           Column(
          //                 children: List.generate(
          //         controller.PopularData.length,
          //   (index) => BigCard(context,controller.PopularData[index],index,'Trending')
          //                 ),
          //               ),
                            
          //               ),
                        
                        const SizedBox(height: 20,),
                        ],
                      )
                    ),
                           
            
                  ],
                ),
            ),
          ),
                  Positioned(
  bottom: 2,
  left: 0,
  right: 0,
  child: Container(
height: 60, 
width: MediaQuery.of(context).size.width,// Add a fixed height for the banner ad
    alignment: Alignment.center,
child: AdWidget(ad: AdMobHelper.getBannerAd(context)..load(),
    key: UniqueKey(),
),
    
  ),
),
        ],
      ),
);
  }
}