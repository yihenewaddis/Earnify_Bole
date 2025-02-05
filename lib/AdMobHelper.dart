
import 'package:google_mobile_ads/google_mobile_ads.dart';
class AdMobHelper{
  static String get bannerUnitId =>'ca-app-pub-1500047410140952/4927125719';
  static String get interstitialUnitId =>'ca-app-pub-1500047410140952/3614044046';
  static String get rewardedUnitId =>'ca-app-pub-3940256099942544/5224354917';
  static String get nativeUnitId =>'ca-app-pub-1500047410140952/3614044046';
bool isInterstitialAdReady = false;
bool IsBannerAdRedy = false;
InterstitialAd? interstitialAd;
int numOfAttempts = 0;
  static initialization(){
if(MobileAds.instance==null){
      MobileAds.instance.initialize();
    }
  }

void createInterstitialAd(){
InterstitialAd.load(adUnitId: interstitialUnitId, request: AdRequest(), adLoadCallback: InterstitialAdLoadCallback(
  onAdLoaded: (InterstitialAd ad){
    interstitialAd = ad; 
    numOfAttempts = 0;
isInterstitialAdReady = true; 
 showInterstitialAd();
    print('interstitial ad loaded');
  },
  onAdFailedToLoad: (LoadAdError error){
    numOfAttempts++;
    interstitialAd = null;
    isInterstitialAdReady = false;
    if(numOfAttempts<3){
      createInterstitialAd();
    }
    print('interstitial ad failed to load');
  }
));
}


void showInterstitialAd(){
    if (interstitialAd == null) {
      return;
    }

    if (!isInterstitialAdReady) {
      return;
    }
interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
onAdShowedFullScreenContent: (InterstitialAd ad){
    print('interstitial ad shown');
},
onAdDismissedFullScreenContent: (InterstitialAd ad){
  print('interstitial ad dismissed');
  ad.dispose();
},
onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error){
print('interstitial ad failed to show');
  ad.dispose();
  createInterstitialAd();
}
);
interstitialAd!.show();
isInterstitialAdReady = false;

  interstitialAd = null;
}
static BannerAd getBannerAd(context, {double? width, double? height}){
BannerAd bAd =  BannerAd(size: AdSize(width: width?.toInt() ?? AdSize.banner.width, height: height?.toInt() ?? AdSize.banner.height), adUnitId: bannerUnitId, listener: BannerAdListener(
        onAdLoaded: (Ad ad){
          
          print('add loaded');
        },
        onAdFailedToLoad: (Ad ad ,LoadAdError error){
          print('add failed to load');
          ad.dispose();
        },
        onAdClosed: (Ad ad){
          print('ad closed');
        }
       ), request: AdRequest());
       return bAd;
  }
} 