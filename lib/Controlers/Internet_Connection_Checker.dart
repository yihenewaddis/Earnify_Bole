import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class InternetConnectionControler extends GetxController{
   final Connectivity _connectivity = Connectivity();
   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit(){
    super.onInit();
    checkInternet();
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  Future<void> checkInternet() async{
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void CloseButtomShhet(){
    if (Get.isBottomSheetOpen!) {
        Get.back();
      }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result[0] == ConnectivityResult.none) {
        Get.bottomSheet(
          enableDrag: false,
          isDismissible: false,
          isScrollControlled: true,
          Container(
            width: double.infinity,
            height: MediaQuery.of(Get.context!).size.height, // Access context via Get
            color: Colors.white,
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
          ),
        );
    }else{
      if (Get.isBottomSheetOpen!) {
        Get.back();
      }
    }
  }

}