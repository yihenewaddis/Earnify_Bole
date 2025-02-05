import 'package:earnify_bole/AdMobHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool is_swiched = true;
  @override
  Widget build(BuildContext context) {
    Future<void> onLounchUrl(String url) async{
final Uri Singleurl = Uri.parse(url);
if(!await launchUrl(Singleurl)){
  throw Exception('error in the link');
}
}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF101B2D),
   
        title: Text('Settings',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900
        ),),
      ),
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Column(
          children: [

          Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About App',style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 20,
                    color: Color(0xFFA4634E),
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: ()=>onLounchUrl('https://earnify.bolefx.com/privacy-policy-2/'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 11, 138, 242),
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.lock_rounded,color: Colors.white,),
                            ),
                        SizedBox(width: 10,),
                        Text('Privacy Policy',style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 17,
                        ),),
                          ],
                        ),
                        Icon(Icons.navigate_next_outlined)
                      ],
                    ),
                  ),
                   SizedBox(height: 20,),
                  GestureDetector(
                    onTap: ()=>onLounchUrl('https://play.google.com/store/apps/details?id=earnify.bolefx.com'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:  Colors.pink,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.star_border,color: Colors.white,),
                             ),
                             SizedBox(width: 10,),
                        Text('Rate this App',style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 17,
                        ),),
                          ],
                        ),
                        Icon(Icons.navigate_next_outlined)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
           Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Social Setting',style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 20,
                    color: Color(0xFFA4634E),
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: ()=>onLounchUrl('https://earnify.bolefx.com/contact/'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:  Color.fromARGB(255, 244, 78, 7),
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.email_outlined,color: Colors.white,),
                             ),
                             SizedBox(width: 10,),
                        Text('Contact us',style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 17,
                        ),),
                          ],
                        ),
                        Icon(Icons.navigate_next_outlined)
                      ],
                    ),
                  ),
                   SizedBox(height: 20,),
                  GestureDetector(
                    onTap: ()=>onLounchUrl('https://earnify.bolefx.com/'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:  Colors.pink,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.link,color: Colors.white,),
                             ),
                             SizedBox(width: 10,),
                        Text('Our Website',style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 17,
                        ),),
                          ],
                        ),
                        Icon(Icons.navigate_next_outlined)
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: ()=>onLounchUrl('https://facebook.com/bolefx'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:  Colors.blue,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.facebook,color: Colors.white,),
                             ),
                             SizedBox(width: 10,),
                        Text('Facebook Page',style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 17,
                        ),),
                          ],
                        ),
                        Icon(Icons.navigate_next_outlined)
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}