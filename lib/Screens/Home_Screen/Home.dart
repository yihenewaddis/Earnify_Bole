import 'package:earnify_bole/AdMobHelper.dart';
import 'package:earnify_bole/Controlers/FetchCategoryController.dart';
import 'package:earnify_bole/Controlers/NotificationController.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/Ai.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/All.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/AndroidApps.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/AndroidTips.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/BestWebsite.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/Crypto.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/Earnify.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/EarningApps.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/Forex.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/Sport.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/Tech.dart';
import 'package:earnify_bole/Screens/Home_Screen/Notification.dart';
import 'package:earnify_bole/Screens/Home_Screen/Search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final catagoryController = Get.put(CategoryController());
final NotificationController _NotificationController = Get.put(NotificationController());

Future<void> onLounchUrl(String url) async{
final Uri Singleurl = Uri.parse(url);
if(!await launchUrl(Singleurl)){
  throw Exception('error in the link');
}
}

    return DefaultTabController(
length:11, 
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[100],
         drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 230,
              color: Colors.grey[200],
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/logo.png'),width: 40,height: 40,),
                        Text(' EARNIFY BOLE',style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,  
                        ),),
                        
                      ],
                    ),
                    Text('App Version: 1.0.1')
                  ],
                  
                ),
            ),
            const SizedBox(height: 10,),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading:const Icon(Icons.person_2_outlined),
              title:const Text('About us'),
              onTap: ()=>onLounchUrl('https://blog.bolenav.com/about-us/'),
            ),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading:const Icon(Icons.link),
              title:const Text('Website'),
              onTap: ()=>onLounchUrl('https://blog.bolenav.com'),
            ),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading:const Icon(Icons.facebook),
              title:const Text('FaceBook'),
              onTap: ()=>onLounchUrl('https://facebook.com/bolenav/'),
            ),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading:const Icon(Icons.email_outlined),
              title:const Text('Contact us'),
              onTap: ()=>onLounchUrl('https://blog.bolenav.com/contact-us/'),
            ),
            
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading:const Icon(Icons.contrast_outlined),
              title:const Text('Term and condition'),
              onTap: ()=>onLounchUrl('https://blog.bolenav.com/terms-and-conditions/'),
            ),
            
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading:const Icon(Icons.perm_device_info),
              title:const Text('Disclaimer'),
              onTap: ()=>onLounchUrl('https://blog.bolenav.com/disclaimer/'),
            ),
          ],
        ),
      ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title:Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image(image: AssetImage('assets/logo.png'),width: 25,height: 25,),
              Text("Earnify Bole",style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold
              ))
            ],
          ),
        ),
        leading: GestureDetector(
          onTap: () {
              scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
          child: Container(
            child:const Icon(Icons.menu,size: 30,color: Colors.black,),
          ),
        ),
        actions: [
          GestureDetector(
            
            onTap: ()=>Get.to(
              transition: Transition.downToUp,
              duration:const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              const SearchScreen()),
            child:const Icon(Icons.search,size: 30,weight: 10,color: Colors.black,)),
          const SizedBox(width: 15,),
          const SizedBox(width: 15,),
        ],

    bottom:  TabBar(
              tabAlignment: TabAlignment.center,        
              labelColor: Colors.black,
              labelStyle:const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              color:Colors.grey[500]
              ),
              isScrollable: true,
              padding: EdgeInsets.all(0),
              indicatorColor: Colors.black,
              indicatorPadding: EdgeInsets.zero, 
              tabs:const [
              Tab(
                text: '  All  ',
              ),
              Tab(
                text: '  AI  ',
              ),
              Tab(
                text: 'Android Apps',
              ),
              Tab(
                text: 'Android tips',
              ),
              Tab(
                text: 'Best Website',
              ),
              Tab(
                text: 'Crypto',
              ),
              Tab(
                text: 'Earnify',
              ),
              Tab(
                text: 'Earning apps',
              ),
              Tab(
                text: 'Forex',
              ),
              Tab(
                text: 'Sport',
              ),
              Tab(
                text: 'Tech',
              ),
            
            ]),
              
            ),
          ],
          
          body:Stack(
            children: [
              const TabBarView(children: [
              All(),
              AI(),
              AndroidApps(),
              AndroidTips(),
              BestWebsite(),
              Crypto(),
              Earnify(),
              EarningApps(),
              Forex(),
              Sport(),
              Tech()
                      ]),
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
        ),



     

      ));
      
  }
}













