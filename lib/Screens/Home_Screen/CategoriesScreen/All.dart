import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/AdController.dart';
import 'package:earnify_bole/Controlers/AiController.dart';
import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Detail.dart';
import 'package:earnify_bole/Screens/Home_Screen/Trending.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:earnify_bole/Widgets/ImageEnhanced.dart';
import 'package:earnify_bole/Widgets/SmallCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    final AllPostController = Get.put(AllController());
    void _onRefresh() async {
      AllPostController.AllData.value = [];
      await AllPostController.fetchAllData(1, 0);
// await Popularcontroller.fetchPopularData(1, 16);
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await AllPostController.fetchMoreAllData(
          AllPostController.PageForMorData.value, 0);

      _refreshController.loadComplete();
    }
AdMobHelper adMobHelper = AdMobHelper();
    return Scaffold(
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
              SizedBox(
                height: 10,
              ),

              // couresel page
              Obx(() => (AllPostController.AllData.isEmpty)
                  ? shimmerEffect_2(context)
                  : SizedBox(
                      height: 220,
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
                                        ['jetpack_featured_media_url']
                                  };
                                  Get.toNamed('/detail');
                                },
                                child: Stack(
                                  children: [
                                    imageEnhanced(
                                        AllPostController.AllData[index]
                                            ["jetpack_featured_media_url"]),
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
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
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
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                      color: Colors.grey[100]),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  'All Posts ',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Colors.grey[100],
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Colors.grey[100],
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    DateFormatter
                                                        .getRelativeTime(
                                                            AllPostController
                                                                    .AllData[
                                                                index]['date']),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color:
                                                            Colors.grey[100]),
                                                  )
                                                ],
                                              ),
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
                                          ? Colors.black
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
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Popular News',
                                style: TextStyle(
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
                            child: Text(
                              'View All   ',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                   SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => (Popularcontroller.PopularData.isEmpty)
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
                                  shimmerEffect_2(context)
                                ],
                              )
                            : Column(
                                children: List.generate(
                                    (Popularcontroller.PopularData.length > 5)
                                        ? 5
                                        : Popularcontroller.PopularData.length,
                                (index) => Column(
                                  children: [
   
    // Original GestureDetector
    GestureDetector(
      onTap: () {
         adMobHelper.createInterstitialAd();
        DetailControllers.data.value = {
          'id': Popularcontroller.PopularData[index]['id'],
          'title': Popularcontroller.PopularData[index]['title']['rendered'],
          'content': Popularcontroller.PopularData[index]['content']['rendered'],
          'date': Popularcontroller.PopularData[index]['date'],
          'image': Popularcontroller.PopularData[index]['jetpack_featured_media_url']
        };
        Get.toNamed('/detail');
      },
      child: SmallCard(
        context,
        Popularcontroller.PopularData[index],
        index
      ),
    ),
                                  ],
                                )),
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 25,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Latest News',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => (AllPostController.AllData.isEmpty)
                            ? shimmerEffect_2(context)
                            : Column(
                                children: List.generate(
                                  AllPostController.AllData.length,
                              (index) => BigCard(context,
                                  AllPostController.AllData[index],index ,'All'),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
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
