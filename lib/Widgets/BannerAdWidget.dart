import 'package:earnify_bole/Controlers/AdController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
    BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = AdManager.instance.createBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
 @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (AdManager.instance.isAdLoaded.value && _bannerAd != null) {
        return Container(
          alignment: Alignment.center,
          child: SizedBox(
            height: _bannerAd!.size.height.toDouble(),
            width: double.infinity,
            child: AdWidget(ad: _bannerAd!),
          ),
        );
      }
      return const SizedBox();
    });
  }
}