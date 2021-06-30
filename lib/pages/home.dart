import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:weather_app/classes/AdHelper.dart';

class WeatherHomePage extends StatefulWidget {
  WeatherHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  // TODO: Add _bannerAd
  late BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  AdHelper helper = new AdHelper();
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
    //Flash the interstitial ad at startup
    helper.flashInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: GestureDetector(
          onTap: () {
            helper.loadInterstitialAd();
            helper.showInterstitialAd();
          },
          child: Icon(
            Icons.menu,
          ),
        )
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.lightBlue.shade100,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/weather.png',
              width: 120,
              height: 150,
            ),
            Weather(),
            /*
            FloatingActionButton.extended(
              onPressed: _loadIntAd,
              tooltip: 'Load Interstitial Ad',
              icon: Icon(Icons.add),
              label: Text('Load Ad'),
            ), // This trailing comma makes auto-formatting nicer for build methods.
            */
            // TODO: Display a banner when ready
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
