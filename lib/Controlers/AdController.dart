import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

class AdManager extends GetxController {
  final isAdLoaded = false.obs;
  int retryAttempt = 0;
  static const int maxRetries = 3;
  BannerAd? bannerAd; // Add this property

  static AdManager get instance => Get.find<AdManager>();

  @override
  void onInit() {
    super.onInit();
    bannerAd = createBannerAd();
  }

  BannerAd createBannerAd() {
    if (retryAttempt >= maxRetries) {
      print('Max retry attempts reached');
      return null!;
    }

    BannerAd newBannerAd = BannerAd(  // Changed to local variable
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded successfully');
          isAdLoaded.value = true;
          retryAttempt = 0;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
          ad.dispose();
          retryAttempt++;
          
          int delaySeconds = pow(2, retryAttempt).toInt() * 5;
          Future.delayed(Duration(seconds: delaySeconds), () {
            bannerAd = createBannerAd();  // Update the class property
          });
        },
        onAdOpened: (Ad ad) => print("Ad opened"),
      ),
      request: const AdRequest(),
    );

    newBannerAd.load();
    return newBannerAd;
  }

  Widget getBannerAdWidget() {
    if (bannerAd == null) return const SizedBox();
    
    return SizedBox(
      height: bannerAd!.size.height.toDouble(),
      width: bannerAd!.size.width.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }
}