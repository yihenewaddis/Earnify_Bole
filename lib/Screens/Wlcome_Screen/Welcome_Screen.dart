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
storageData.write('Booked', []);
  }
  PageController _controler = PageController();
  bool   IsFirstPage = true;
  bool   IsLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101B2D),
    body:Stack(
      
      children: [
            
            PageView(
              controller: _controler,
              onPageChanged: (index){
                setState(() {
                  IsFirstPage = (index == 0);
                  IsLastPage = (index == 2);
                });
              },
          children: [

            Container(
              color: Color(0xFF101B2D),
              child: Column(
                children: [
                   const Expanded(
                    flex: 2,
                    child:Row(
                      children: [

                      ],
                    )),
                   const Expanded(
                    flex: 5,
                    child: Image(
                      width: 350,
                      height: 350,
                      fit: BoxFit.contain,
                      image: AssetImage('assets/Page1.png'))),
                  Expanded(
                    flex: 3,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Welcome to BoleNav",style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                          ),),


                          
                          
                         const Padding(
                            padding:  EdgeInsets.all(1),
                            child: Text('Start earning online today',style: TextStyle(
                                  color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                                ),
                            textAlign: TextAlign.center,
                              ),
                          ),
SizedBox(height: 40,),
                         GestureDetector(
                          onTap: (){
_controler.nextPage(duration:const Duration(milliseconds: 300), curve:Curves.easeIn);
                          },
                          child:  Container(
                            padding: EdgeInsets.symmetric(horizontal: 140,vertical: 20),
                            decoration: BoxDecoration(
                              color:  Colors.black,
                              borderRadius: BorderRadius.circular(40)
                            ),
                            child: Text(
                              "Start",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                         )
                          
                        ],
                      ),
                  )
                ],
              ),
            ),


            Container(
              color: Color(0xFF101B2D),
              child: Column(
                children: [
                   const Expanded(
                    flex: 2,
                    child:Row(
                      children: [

                      ],
                    )),
                   const Expanded(
                    flex: 5,
                    child: Image(
                      width: 350,
                      height: 350,
                      fit: BoxFit.contain,
                      image: AssetImage('assets/Page2.png'))),
                  Expanded(
                    flex: 3,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          


                          
                          
                         const Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Discover simple trust ways to earn money.',style: TextStyle(
                                  color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                                ),
                            textAlign: TextAlign.center,
                              ),
                          ),
SizedBox(height: 40,),
                         GestureDetector(
                          onTap: (){
_controler.nextPage(duration:const Duration(milliseconds: 300), curve:Curves.easeIn);
                          },
                          child:  Container(
                            padding: EdgeInsets.symmetric(horizontal: 140,vertical: 20),
                            decoration: BoxDecoration(
                              color:  Colors.black,
                              borderRadius: BorderRadius.circular(40)
                            ),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'inter',
                                fontSize: 16,

                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                         )
                          
                        ],
                      ),
                  )
                ],
              ),
            ),


           Container(
              color: Color(0xFF101B2D),
              child: Column(
                children: [
                   const Expanded(
                    flex: 2,
                    child:Row(
                      children: [

                      ],
                    )),
                   const Expanded(
                    flex: 5,
                    child: Image(
                      width: 350,
                      height: 350,
                      fit: BoxFit.contain,
                      image: AssetImage('assets/Page3.png'))),
                  Expanded(
                    flex: 3,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          


                          
                          
                         const Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Let's navigate your journey to financial success",style: TextStyle(
                                 color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500
                                ),
                            textAlign: TextAlign.center,
                              ),
                          ),
SizedBox(height: 40,),
                         GestureDetector(
                          onTap: (){
Get.offNamed('/initialScreen');
                          },
                          child:  Container(
                            padding: EdgeInsets.symmetric(horizontal: 100,vertical: 20),
                            decoration: BoxDecoration(
                              color:  Colors.black,
                              borderRadius: BorderRadius.circular(40)
                            ),
                            child: Text(
                              "Enter to the app",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                         )
                          
                        ],
                      ),
                  )
                ],
              ),
            ),
          ],
        ),




        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          alignment:const Alignment(0, -0.85),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              IsFirstPage ?
                const SizedBox(width: 40,):
                GestureDetector(
                    onTap: () {
                      _controler.previousPage(duration:const Duration(milliseconds: 300), curve:Curves.easeIn);
              
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal:10,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.keyboard_double_arrow_left_rounded,color: Colors.white,),
                        Text('Back',style: TextStyle(
                          color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'inter'
                ),)
                      ],
                    ),
                  )),

    


               
                    GestureDetector(
                    onTap: () {
                      if(IsLastPage){
                        Get.offNamed('/initialScreen');
                      }else{
                      _controler.nextPage(duration:const Duration(milliseconds: 300), curve:Curves.easeIn); }
                    },
                    child:const Text('Skip',style: TextStyle(
                      color: Colors.white,
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
