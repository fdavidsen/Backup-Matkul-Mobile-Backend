import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Home13 extends StatefulWidget {
  const Home13({super.key});

  @override
  State<Home13> createState() => _Home13State();
}

class _Home13State extends State<Home13> {
  int coin = 0;

  late BannerAd _bannerAd;
  bool _isBannerReady = false;

  late InterstitialAd _interstitialAd;
  bool _isInterstitialReady = false;

  late RewardedAd _rewardedAd;
  bool _isRewardedReady = false;

  @override
  void initState() {
    _loadBannedAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.monetization_on,
                    size: 50,
                  ),
                  Text(
                    coin.toString(),
                    style: const TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    _loadInterstisialAd();
                    if (_isInterstitialReady) {
                      _interstitialAd.show();
                    }
                  },
                  child: const Text('Interstitial Ads')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    _loadRewardedAd();
                    if (_isRewardedReady) {
                      _rewardedAd.show(onUserEarnedReward:
                          (AdWithoutView ad, RewardItem reward) {
                        setState(() {
                          coin += 1;
                        });
                      });
                    }
                  },
                  child: const Text('Rewarded Ads')),
            ),
            Expanded(
                child: _isBannerReady
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: _bannerAd.size.width.toDouble(),
                          height: _bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd),
                        ),
                      )
                    : Container())
          ],
        ),
      ),
    );
  }

  void _loadBannedAd() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              _isBannerReady = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            _isBannerReady = false;
            ad.dispose();
          },
        ),
        request: AdRequest());
    _bannerAd.load();
  }

  void _loadInterstisialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            print('Close Interstitial Ad');
          });
          setState(() {
            _isInterstitialReady = true;
            _interstitialAd = ad;
          });
        }, onAdFailedToLoad: (err) {
          _isInterstitialReady = false;
          _interstitialAd.dispose();
        }));
  }

  void _loadRewardedAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _isRewardedReady = false;
              });
              _loadRewardedAd();
            },
          );
          setState(() {
            _isRewardedReady = true;
            _rewardedAd = ad;
          });
        }, onAdFailedToLoad: (err) {
          setState(() {
            _isRewardedReady = false;
            _rewardedAd.dispose();
          });
        }));
  }
}
