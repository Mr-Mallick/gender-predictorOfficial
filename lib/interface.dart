import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gender_predictator/drawer.dart';
import 'package:gender_predictator/loader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

const String testdevice = '';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: <String>[],
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

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: "ca-app-pub-8105441267168999/5194069129",
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("Banner event : $event");
      },
    );
  }

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

  TextEditingController _nameController = TextEditingController();
  var result;
  StreamSubscription<DataConnectionStatus> listener;
  bool loading = false;
  var _formKey = GlobalKey<FormState>();

  predictGender(String name) async {
    DataConnectionStatus status = await checkInternet();
    if (status == DataConnectionStatus.connected) {
      var website = "https://api.genderize.io/?name=$name";
      var res = await http.get(website);
      var tresult = jsonDecode(res.body);
      result =
          "Name: $name\nGender: ${tresult['gender']}\nProbability: ${tresult['probability']}";
      setState(() {
        loading = false;
      });
    } else {
      loading = false;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "No Internet",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffFF5C5C)),
          ),
          content: Text(
            "Check your connection.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xffFF5C5C),
            ),
          ),
          actions: <Widget>[
            FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xffFF5C5C)),
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFF5C5C),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage()),
                  );
                }),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-8105441267168999~7912087025");
    _bannerAd = createBannerAd()
      ..load()
      ..show();

    _interstitialAd = createInterstitialAd()..load();

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    listener.cancel();
    super.dispose();
  }

  checkInternet() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum value instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    // this will cause DataConnectionChecker to check periodically
    // with the interval specified in DataConnectionChecker().checkInterval
    // until listener.cancel() is called
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          break;
      }
    });

    return await DataConnectionChecker().connectionStatus;
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
      body: loading
          ? Center(child: Loader())
          : Container(
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
                          "Gender",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Predictor",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
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
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xffFF5C5C),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: startingtext(),
                                      ),
                                      Container(child: gettinginformation()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                button(),
                                if (result != null)
                                  Container(child: alertresultbox()),
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

// if (result != null)
//                             Container(
//                               child: alertresultbox(),
//                             )

  Widget startingtext() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]))),
      child: Text(
        "Enter Name to Predict Gender",
        style: TextStyle(
          // fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Color(0xffFF5C5C),
        ),
      ),
    );
  }

  Widget gettinginformation() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]))),
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: _nameController,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
            // BlacklistingTextInputFormatter(RegExp("[,.!@#]")),
          ],
          validator: (String value) {
            if (value.length <= 3) {
              return "Atleast 4 word required";
            }
            if (value.isEmpty) {
              return 'Please Enter Name to Continue';
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: "Name",
              hintStyle: TextStyle(color: Color(0xffFF5C5C)),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Color(0xffFF5C5C)),
      ),
      onPressed: () {
        createInterstitialAd()
          ..load()
          ..show();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => display()),
        // );

        setState(() {
          if (_formKey.currentState.validate()) {
            loading = true;
            predictGender(_nameController.text);
          }
          // loading = true;
        });
        // predictGender(_nameController.text);
      },
      child: Text(
        "Predict",
        style: TextStyle(color: Color(0xffFF5C5C), fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget alertresultbox() {
    return (Container(
        child: Align(
      alignment: Alignment.center,
      child: Container(
        child: AlertDialog(
          // titleTextStyle: TextStyle() ,
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          )),
          backgroundColor: Colors.grey[200],
          title: Text(
            "Result",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xffFF5C5C),
            ),
          ),
          content: Text(
            result,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xffFF5C5C),
            ),
          ),
        ),
      ),
    )));
  }
}
