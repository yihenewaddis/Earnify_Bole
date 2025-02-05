
import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/CryptoController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class Crypto extends StatelessWidget {
  const Crypto({super.key});

  @override
  Widget build(BuildContext context) {

      RefreshController _refreshController = RefreshController(initialRefresh: false);
      final controller = Get.put(CryptoController());
      final AllPostController = Get.find<AllController>();
  void _onRefresh() async{
  controller.CryptoData.value = [];
  await controller.fetchCryptoData(1, 6);
    _refreshController.refreshCompleted();
  }


  void _onLoading() async{
await controller.fetchMoreCryptoData(controller.PageForMorData.value,6);
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
                        () => (controller.CryptoData.isEmpty)
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
                                        controller.CryptoData.length,
                                    itemBuilder: (context, index) {
                                      return GridCard(
                                        context,
                                        controller.CryptoData[index],
                                        index,
                                        'Crypto',
                                      );
                                    },
                                  )
                                : Column(
                                    children: List.generate(
                                      controller.CryptoData.length,
                                      (index) => BigCard(
                                          context,
                                          controller.CryptoData[index],
                                          index,
                                          'Crypto'),
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