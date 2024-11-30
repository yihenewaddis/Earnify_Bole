import 'package:earnify_bole/Controlers/Internet_Connection_Checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class Welcome_Screen1 extends StatefulWidget {
  Welcome_Screen1({super.key});

  @override
  State<Welcome_Screen1> createState() => _Welcome_Screen1State();
}

class _Welcome_Screen1State extends State<Welcome_Screen1> {
  final Interconnectioncontroler = Get.put(InternetConnectionControler());
  PageController _controler = PageController();
  bool Islastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Obx((){
      if(Interconnectioncontroler.isConnected.value){
        return Stack(
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
                const SizedBox(width: 30,):
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
    );
      }else{
        return Container(
          child: Column(
            children: [
              const SizedBox(height: 100,),
              const Expanded(
                flex: 2,
                child: Image(image: AssetImage('assets/noInternet.jpg'),fit: BoxFit.contain,)),
              Expanded(
                flex: 1,
                child: Column(
                children: [
                  const Text('No internet connection',style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                  ),),
                  
                  const Text('check your internet connection',style: TextStyle(
                    fontSize: 16
                  ),),



                  GestureDetector(
                    onTap:()=> Interconnectioncontroler.checkInternet(),
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      padding: EdgeInsets.symmetric(horizontal: 100,vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child:const Text('Try again',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  )
                ],
              ))
            ],
          ),
        );
      }
    })
    );
  }
}
