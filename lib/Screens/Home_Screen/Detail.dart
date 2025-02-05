import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/BookMarkedController.dart';
import 'package:earnify_bole/Controlers/CommentController.dart';
import 'package:earnify_bole/Controlers/DetailController.dart';
import 'package:earnify_bole/Controlers/PopularController.dart';
import 'package:earnify_bole/Screens/Home_Screen/Comment.dart';
import 'package:earnify_bole/Widgets/BigCard.dart';
import 'package:earnify_bole/Widgets/ShimmerEffect.dart';
import 'package:earnify_bole/Widgets/SmallCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

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

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailController>();
    final Popularcontroller = Get.find<PopularController>();
final commentController = Get.put(CommentController());
    final scrollController = ScrollController();
final bookMarkedController = Get.find<BookMarkedController>();
    
  final storageData = GetStorage();
  
print('related');
print(controller.Relateddata);

 final isBookmarkedRx = false.obs;
bool isBookmarked() {
    List Booked = storageData.read('Booked') ?? [];
    return Booked.any((item) => item['id'] == controller.data['id']);
  }
  isBookmarkedRx.value = isBookmarked();
    ever(controller.data, (_) {
      isBookmarkedRx.value = isBookmarked();
    });


 void BookMark(data) {
    List Booked = storageData.read('Booked') ?? [];

    if (isBookmarked()) {
      Booked.removeWhere((item) => item['id'] == data['id']);
    } else {
      Booked.add({
      'id': data['id'],
        'title': data['title'], // Removed ['rendered']
        'content': data['content'], // Removed ['rendered']
        "date": data['date'],
        "image": data['image'] 
      });
    }
    storageData.write('Booked', Booked);
    // Update the reactive state
    isBookmarkedRx.value = !isBookmarkedRx.value;
  }
// AdMobHelper adMobHelper = AdMobHelper();

// adMobHelper.showInterstitialAd();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          
          Positioned(
            top: 0,
            left: 0,
            child: Obx(() => CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
height: 360,
                  imageUrl: controller.data['image'],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.white, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) => shimmerEffect_1(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )),
          ),

          SafeArea(child: SingleChildScrollView(
            controller: scrollController,
            
            child: Container(
              
margin: const EdgeInsets.only(top: 300),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_circle_rounded,
                                    color: Color(0xFF101B2D),
                                    size: 50,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Admin',
                                        style: TextStyle(
                                          color: Color(0xFF101B2D),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Obx(() => Text(
                                            DateFormatter.getRelativeTime(
                                                controller.data['date']),
                                            style: TextStyle(
                                                color: Color(0xFF101B2D)),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                              GestureDetector(
onTap: () =>{ 
  commentController.postId.value = controller.data['id'],
  Get.to(CommentScreen())
  },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF101B2D),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.message_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        ' Comments',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
SizedBox(height: 10),
                        
SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width.toDouble(),
        child: AdWidget(
ad: AdMobHelper.getBannerAd(context,width: MediaQuery.of(context).size.width.toDouble(),height: 250)..load(),
          key: UniqueKey(),
        ),
      ),
      SizedBox(height: 20),
HtmlWidget(
                      controller.data['title'],
                          textStyle:
                          TextStyle(
fontWeight: FontWeight.bold,
                            fontSize: 20, color: Colors.grey[800]),
                        ),
                        HtmlWidget(
                          controller.data['content'],
                          textStyle:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        
                        SizedBox(height: 10),
                        


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
                          'Related Articles',
                              style: TextStyle(
                                color: Color(0xFF101B2D),
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),





      Obx(() =>  Column(
                          children: List.generate(
(controller.Relateddata.length > 5)
                                  ? 5
                                  : controller.Relateddata.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      controller.data.value = {
                                        'id': controller.Relateddata[index]['id'],
                                        'title': controller.Relateddata[index]['title']['rendered'], 
                                        'content':controller.Relateddata[index]
                                                ['content']['rendered'],
                                        'date':controller.Relateddata[index]['date'],
                                        'image':controller.Relateddata[index]
                                                ['jetpack_featured_media_url']
                                      };
                                      scrollController.animateTo(
                                        0,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: BigCard(context,
                                    controller.Relateddata[index],index,'Popular'),
                                  )),
                        ),
),


SizedBox(height: 50,),

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
                              'Articles you may Love',
                              style: TextStyle(
                                color: Color(0xFF101B2D),
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: List.generate(
                              (Popularcontroller.PopularData.length > 5)
                                  ? 5
                                  : Popularcontroller.PopularData.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      controller.data.value = {
                                        'id': Popularcontroller
                                            .PopularData[index]['id'],
'title': Popularcontroller
                                        .PopularData[index]['title']['rendered'], 
                                        'content':
                                            Popularcontroller.PopularData[index]
                                                ['content']['rendered'],
                                        'date': Popularcontroller
                                            .PopularData[index]['date'],
                                        'image':
                                            Popularcontroller.PopularData[index]
                                                ['jetpack_featured_media_url']
                                      };
                                      scrollController.animateTo(
                                        0,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: BigCard(context,
                                    Popularcontroller.PopularData[index],index,'Popular'),
                                  )),
                        ),
                       SizedBox(height: 10),
                        
SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width.toDouble(),
        child: AdWidget(
ad: AdMobHelper.getBannerAd(context,width: MediaQuery.of(context).size.width.toDouble(),height: 250)..load(),
          key: UniqueKey(),
        ),
  ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xFF101B2D),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                        weight: 100,
                        color: Colors.white,
                      )),
                ),
                Row(
                  children: [
Obx(() => GestureDetector(
                          onTap: () => BookMark(controller.data),
                          child: isBookmarkedRx.value
      ? Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
              color: Color(0xFF101B2D),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(
Icons.bookmark_add_outlined,
                            size: 25,
                            weight: 100,
                        color: Colors.red,
                          ))
      : Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xFF101B2D),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(
Icons.bookmark_add_outlined,
                            size: 25,
                            weight: 100,
                            color: Colors.white,
                          )),
  )),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Share.share(controller.data['Link'])
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xFF101B2D),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(
                            Icons.share,
                            size: 25,
                            weight: 100,
                            color: Colors.white,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
                  Positioned(
  bottom: 0,
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
