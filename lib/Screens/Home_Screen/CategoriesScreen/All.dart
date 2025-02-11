import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Trending.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/GridCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
import 'package:earnify_bole/Widgets/SmallCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
class DateFormatter {
  static String getRelativeTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    final Popularcontroller = Get.put(PopularController());
    final DetailControllers = Get.put(DetailController());
    final bookMarkedController = Get.put(BookMarkedController());
    final AllPostController = Get.find<AllController>();
    void _onRefresh() async {
      AllPostController.AllData.value = [];
      Popularcontroller.PopularData.value = [];
       AllPostController.fetchAllData(1, 0);
await Popularcontroller.fetchPopularData(1, 10);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await AllPostController.fetchMoreAllData(
          AllPostController.PageForMorData.value, 0);

      _refreshController.loadComplete();
    }
AdMobHelper adMobHelper = AdMobHelper();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),

              // couresel page
              Obx(() => (AllPostController.AllData.isEmpty)
                  ? shimmerEffect_2(context)
                  : SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: PageView.builder(
                          onPageChanged: (index) {
                            AllPostController.changeCurrentIndex(index);
                          },
                          itemCount: AllPostController.AllData.length > 10
                              ? 10
                              : AllPostController.AllData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  adMobHelper.createInterstitialAd();
DetailControllers.Relateddata.value = Popularcontroller.PopularData;
                                  DetailControllers.data.value = {
                                    'id': AllPostController.AllData[index]
                                        ['id'],
                                    'title': AllPostController.AllData[index]
                                        ['title']['rendered'],
                                    'content': AllPostController.AllData[index]
                                        ['content']['rendered'],
                                    'date': AllPostController.AllData[index]
                                        ['date'],
                                    'image': AllPostController.AllData[index]
                                        ['jetpack_featured_media_url'],
                                    "Link": AllPostController.AllData[index]['link']
                                  };
                                  Get.toNamed('/detail');
                                },
                                child: Stack(
                                  children: [
                                    imageEnhanced(AllPostController.AllData[index]['jetpack_featured_media_url']),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 120,
                                          
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 10),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  AllPostController
                                                          .AllData[index]
                                                      ['title']['rendered'],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 18,
                                                      color: Colors.grey[100]),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF101B2D),
                                                  borderRadius:
                                                      BorderRadius.circular(20),

                                                ),
                                                child:  Text('Read More',style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                                ),),
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),

              SizedBox(
                height: 10,
              ),

              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0;
                        i <
                            ((AllPostController.AllData.length > 10)
                                ? 10
                                : AllPostController.AllData.length);
                        i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Obx(() => Container(
                              height: 6,
                              width: (AllPostController.CurrentPageIndex == i)
                                  ? 12
                                  : 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color:
                                      (AllPostController.CurrentPageIndex == i)
                                          ? Color(0xFF101B2D)
                                          : Colors.grey[500],
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                      )
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),



      SizedBox(
height:100,
width: MediaQuery.of(context).size.width.toDouble(),
        child: Stack(
          children: [
            SizedBox(height: 10,),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Text('AD'),
              ),
            ),
            AdWidget(
            ad: AdMobHelper.getBannerAd(context)..load(),
              key: UniqueKey(),
            ),
          ],
        ),
      ),


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
                                    color: Color(0xFF101B2D),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Popular posts',
                                style: TextStyle(
                                  color: Color(0xFF101B2D),
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Get.to(
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                TrendingScreen()),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.black,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                 



                      
                      Obx(
                        () => (Popularcontroller.PopularData.isEmpty)
                            ? SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder:(context, index){return shimmerEffect_2(context);} , itemCount: 5),
                            )
            :   SizedBox(


 
              height: 260, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (Popularcontroller.PopularData.length > 5)
                                          ? 5
                                          : Popularcontroller.PopularData.length,
                itemBuilder:   (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        adMobHelper.createInterstitialAd();
                        final popularController = Get.find<PopularController>();
                        DetailControllers.Relateddata.value = popularController.PopularData;
                        DetailControllers.data.value = {
                          'id': Popularcontroller.PopularData[index]['id'],
                          'title': Popularcontroller.PopularData[index]['title']['rendered'],
                          'content': Popularcontroller.PopularData[index]['content']['rendered'],
                          'date': Popularcontroller.PopularData[index]['date'],
                          'image': Popularcontroller.PopularData[index]['jetpack_featured_media_url'],
                          'Link':Popularcontroller.PopularData[index]['link']
                        };
                        Get.toNamed('/detail');
                      },
                      child: SmallCard(
                        context,
                        Popularcontroller.PopularData[index],
                        index,
                        'Popular'
                      ),
                    ),
                    
                  ],
                );
              },
               ),
            ),),





                
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                            width: 5,
                            height: 25,
                            decoration: BoxDecoration(
                                color: Color(0xFF101B2D),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Latest posts',
                            style: TextStyle(
                              color: Color(0xFF101B2D),
                                fontSize: 20, fontWeight: FontWeight.w700),
                          )
                            ],
                          ),
                          GestureDetector(
                            onTap: () => AllPostController.ChangeLayout(),
                            child: Obx(() => Icon(
                              (AllPostController.IsGrid.value)
                                  ? Icons.grid_view
                                  : Icons.line_style_rounded,
                              color: Colors.black,
                              size: 25,
                            )),
                          )
                        ],
                      ),
              
              
                      Obx(
                        () => (AllPostController.AllData.isEmpty)
                            ? shimmerEffect_2(context)
                            : AllPostController.IsGrid.value? GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: AllPostController.AllData.length,
                            itemBuilder: (context, index) {
                              return GridCard(
                                context,  
                                AllPostController.AllData[index],
                                index,
                                'All',
                              );
                            },
                          ):
                            Column(
                                children: List.generate(
                                  AllPostController.AllData.length,
                              (index) =>BigCard(context,
                          AllPostController.AllData[index],index ,'All'),
                                ),
                              ),
                      ),

                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
