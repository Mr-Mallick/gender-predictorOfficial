import 'package:flutter/material.dart';
import 'package:gender_predictator/interface.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'drawer.dart';

// const String testdevice = '';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      // testDevices: <String>[],
      nonPersonalizedAds: true,
      keywords: <String>[
        'Business Services',
        'Hosting',
        'Software',
        'Loans',
        'Insurance',
        'Cash Services',
        'Mortgage',
        'Credit',
        'Attorney',
        'Lawyer',
        'facebook',
        'whatsapp',
        'gender',
        'predict',
        'prediction',
      ]);

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: "ca-app-pub-8105441267168999/3117326858",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("Interstitial event : $event");
      },
    );
  }

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-8105441267168999~7912087025");
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        // leading: IconButton(
        // icon: Icon(Icons.arrow_back_ios),
        // onPressed: () => exit(0),
        // ),
        title: Center(
          child: Text(
            "Gender Predictor",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          // Color(0xffFF5C5C),
          Color(0xffFC8EA6),
          Color(0xffE75C4A),
          // Color(0xffFC8EA6),
          Color(0xffC98861),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "About",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: details(),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Center(
                                child: button(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget button() {
    return FlatButton(
      // elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Color(0xffFF5C5C)),
      ),
      onPressed: () {
        createInterstitialAd()
          ..load()
          ..show();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirstPage()),
        );
      },
      child: Text(
        "Back to Home",
        style: TextStyle(color: Color(0xffFF5C5C), fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget details() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Gender Predictor is the app which predicts the Gender on the basis of the name.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xffFF5C5C),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                "Features:\n*Predicts the gender i.e. Male/Female\n*Predicts the Probability",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xffFF5C5C),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "Requirement:\n*Name Must be of atleast 4 character",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xffFF5C5C),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Text(
                "Made In INDIA with \u2764",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xffFF5C5C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
