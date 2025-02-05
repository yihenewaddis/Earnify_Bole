import 'package:earnify_bole/Controlers/AllCotroller.dart';
import 'package:earnify_bole/Controlers/FetchCategoryController.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/Category.dart';
import 'package:earnify_bole/Screens/Home_Screen/CategoriesScreen/All.dart';
import 'package:earnify_bole/Screens/Home_Screen/Search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final catagoryController = Get.put(CategoryController());

  final AllPostController = Get.put(AllController());
Future<void> onLounchUrl(String url) async{
final Uri Singleurl = Uri.parse(url);
if(!await launchUrl(Singleurl)){
  throw Exception('error in the link');
}
}

    return  Obx(() => catagoryController.CategoryList.isEmpty?Center(
      child: Image(image: AssetImage('assets/gif.gif')),
    ): DefaultTabController(
length:catagoryController.CategoryList.length+1, 
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
              color:  Color(0xFF101B2D),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10), 
                          child: Image(image: AssetImage('assets/logo.png'),width: 40,height: 40,)),
                        Text(' EARNIFY BOLE',style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,  
                        ),),
                        
                      ],
                    ),
                    Text('App Version: 1.0.1',style: TextStyle(
                      color: Colors.white
                    ),)
                  ],
                  
                ),
            ),
            const SizedBox(height: 10,),
            ListTile(
              textColor: Color(0xFF101B2D),
              iconColor: Color(0xFF101B2D),
              leading:const Icon(Icons.person_2_outlined),
              title:const Text('About us'),
              onTap: ()=>onLounchUrl('https://earnify.bolefx.com/about-us/'),
            ),
            ListTile(
              textColor: Color(0xFF101B2D),
              iconColor: Color(0xFF101B2D),
              leading:const Icon(Icons.link),
              title:const Text('Website'),
              onTap: ()=>onLounchUrl('https://earnify.bolefx.com/'),
            ),
            ListTile(
              textColor: Color(0xFF101B2D),
              iconColor: Color(0xFF101B2D),
              leading:const Icon(Icons.facebook),
              title:const Text('FaceBook'),
              onTap: ()=>onLounchUrl('https://facebook.com/bolefx'),
            ),
            ListTile(
              textColor: Color(0xFF101B2D),
              iconColor: Color(0xFF101B2D),
              leading:const Icon(Icons.email_outlined),
              title:const Text('Contact us'),
              onTap: ()=>onLounchUrl('https://earnify.bolefx.com/contact/'),
            ),
            
            ListTile(
              textColor: Color(0xFF101B2D),
              iconColor: Color(0xFF101B2D),
              leading:const Icon(Icons.contrast_outlined),
              title:const Text('Terms and conditions'),
              onTap: ()=>onLounchUrl('https://earnify.bolefx.com/terms/'),
            ),
            
            ListTile(
              textColor: Color(0xFF101B2D),
              iconColor: Color(0xFF101B2D),
              leading:const Icon(Icons.perm_device_info),
              title:const Text('Disclaimer'),
              onTap: ()=>onLounchUrl('https://earnify.bolefx.com/disclaimer/'),
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
        backgroundColor: Color(0xFF101B2D),
        surfaceTintColor: Colors.white,
        title:Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image(image: AssetImage('assets/logo.png'),width: 25,height: 25,),
              ClipRRect(
                            borderRadius: BorderRadius.circular(5), 
                          child: Image(image: AssetImage('assets/logo.png'),width: 25,height: 25,)),
                          SizedBox(width: 10,),
              Text("Earnify Bole",style: TextStyle(
              color: Colors.white,
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
            child:const Icon(Icons.menu,size: 30,color: Colors.white,),
          ),
        ),
        actions: [
          GestureDetector(
            
            onTap: ()=>Get.to(
              transition: Transition.downToUp,
              duration:const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              const SearchScreen()),
            child:const Icon(Icons.search,size: 30,weight: 10,color: Colors.white,)),
          const SizedBox(width: 15,),
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
          const SizedBox(width: 15,),

        
        ],

    bottom:  TabBar(
      indicatorWeight: 4, 
              tabAlignment: TabAlignment.center,        
              labelColor: Colors.white,
              
              labelStyle:const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              color:Colors.grey[500]
              ),
              isScrollable: true,
              padding: EdgeInsets.all(0),
              indicatorColor: Color(0xFF101B2D),
              indicatorPadding: EdgeInsets.zero, 
              tabs: [
              Tab(
                text: '  All  ',
              ),
              for (int i = 0; i < catagoryController.CategoryList.length; i++)   Tab(
                  text: catagoryController.CategoryList[i]['name'],
                ),
            
            ]),
              
            ),
          ],
          
          body:Stack(
            children: [
              TabBarView(children: [
                All(),
              for (int i = 0; i < catagoryController.CategoryList.length; i++) AI(Id: catagoryController.CategoryList[i]['id']),
                      ]),
 
            ],
          ),
        ),



     

      )));
      
  }
}













