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

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/images/weather.png', width: 120, height: 200,),
              Weather()
            ],
          ),
        )
      ),
    );
  }
}
