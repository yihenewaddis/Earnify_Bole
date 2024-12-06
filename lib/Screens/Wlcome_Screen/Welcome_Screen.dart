import 'package:earnify_bole/Controlers/Internet_Connection_Checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class Welcome_Screen1 extends StatefulWidget {
  Welcome_Screen1({super.key});

  @override
  State<Welcome_Screen1> createState() => _Welcome_Screen1State();
}

class _Welcome_Screen1State extends State<Welcome_Screen1> {
  final storageData = GetStorage();
  void isFirstOpenReset(){
    storageData.write('isFirstOpen', true);
  }
  PageController _controler = PageController();
  bool Islastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:Stack(
      children: [
            
            PageView(
              controller: _controler,
              onPageChanged: (index){
                setState(() {
                  Islastpage = (index == 2);
                });
              },
          children: [

            Container(
              color: Colors.white,
              child:const Column(
                children: [
                    Expanded(
                    flex: 5,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/welcome.jpg'))),
                  Expanded(
                    flex: 2,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Welcome",style: TextStyle(
                            color: Color.fromARGB(255, 1, 72, 3),
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                          ),),


                          
                          
                          Padding(
                            padding:  EdgeInsets.all(8),
                            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam  ',style: TextStyle(
                                  color: Color.fromARGB(255, 1, 72, 3),
                                  fontSize: 20,
                                  
                                ),
                            textAlign: TextAlign.center,
                              ),
                          ),
                          
                        ],
                      ),
                  )
                ],
              ),
            ),


            Container(
              color: Colors.white,
              child:const Column(
                children: [
                    Expanded(
                    flex: 5,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/notification.jpg'))),
                  Expanded(
                    flex: 2,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Get Notification First",style: TextStyle(
                            color:  Color.fromARGB(255, 1, 72, 3),
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                          ),),

                          Padding(
                            padding:  EdgeInsets.all(10.0),
                            child: Text('subscribe and get notification to all of our article & share with your frends..',style: TextStyle(
                                  color:Color.fromARGB(255, 1, 72, 3),
                                  fontSize: 20,
                                  
                                ),
                            textAlign: TextAlign.center,
                              ),
                          ),
                          
                        ],
                      ),
                  )
                ],
              ),
            ),


            Container(
              color: Colors.white,
              child:const Column(
                children: [
                    Expanded(
                    flex: 6,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/share.jpg'))),
                  Expanded(
                    flex: 3,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Save & Share your Favorite Content Easly",style: TextStyle(
                            color:  Color.fromARGB(255, 1, 72, 3),
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                          ),textAlign: TextAlign.center,),

                          Padding(
                            padding:  EdgeInsets.all(10.0),
                            child: Text('Bookmark , like & Coment on your favorite article and share on special meida...',style: TextStyle(
                                  color:Color.fromARGB(255, 1, 72, 3),
                                  fontSize: 20,
                                  
                                ),
                            textAlign: TextAlign.center,
                              ),
                          ),
                          
                        ],
                      ),
                  )
                ],
              ),
            ),
          ],
        ),




        Container(
          alignment:const Alignment(0, 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Islastpage ?
                const SizedBox(width: 35,):
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed('/initialScreen');
                  },
                  child:const Text('Skip',style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)),

              SmoothPageIndicator(
                controller: _controler, 
                count: 3,
                  effect:const ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.black,
                  dotColor: Colors.grey,
                  expansionFactor: 3, // How much the active dot expands
                  spacing: 8, // Spacing between dots
                ),
                
                ),


                Islastpage?
                  GestureDetector(
                    onTap: () {
                    isFirstOpenReset();
                    Get.offAllNamed('/initialScreen');
                  },
                    child:const Text('Done',style: TextStyle(  
                      fontWeight: FontWeight.bold                 
                    ),)):
                    GestureDetector(
                    onTap: () {
                      _controler.nextPage(duration:const Duration(milliseconds: 300), curve:Curves.easeIn);
                    },
                    child:const Text('Next',style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),))
            ],
          ))
      ],
    )



    )
  ;
  }
}
