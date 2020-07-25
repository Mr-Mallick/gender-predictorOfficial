import 'package:flutter/material.dart';
import 'package:gender_predictator/aboutus.dart';

import 'interface.dart';

// ignore: camel_case_types
class myDrawer extends StatefulWidget {
  @override
  _myDrawerState createState() => _myDrawerState();
}

// ignore: camel_case_types
class _myDrawerState extends State<myDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            // Color(0xffFF5C5C),
            Color(0xffFC8EA6),
            // Color(0xffE75C4A),
            // Color(0xffFC8EA6),
            Color(0xffC98861),
          ])),
          child: ListView(
            // padding: EdgeInsets.all(0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  "Gender",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  "Predictor",
                  style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                // currentAccountPicture: CircleAvatar(
                //   child: Text("M"),
                // ),
              ),
              // ListTile(
              //   leading: Image.network("https://dummyimage.com/300.png/09f/fff"),
              //   title: Text(
              //     "Company Name",
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontStyle: FontStyle.italic,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FirstPage()));
                },
                title: home(),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs()));
                },
                title: aboutus(),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              // ListTile(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => FirstPage()));
              //   },
              //   title: share(),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // ListTile(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => FirstPage()));
              //   },
              //   title: feedback(),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget home() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            child: Icon(Icons.home),
          ),
        ],
      ),
    );
  }

  Widget aboutus() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "About Us",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            child: Icon(Icons.info),
          ),
        ],
      ),
    );
  }

  // Widget share() {
  //   return Container(
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Container(
  //           child: Text(
  //             "Share",
  //             style: TextStyle(
  //               fontSize: 18,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           child: Icon(Icons.share),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget feedback() {
  //   return Container(
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Container(
  //           child: Text(
  //             "Feedback",
  //             style: TextStyle(
  //               fontSize: 18,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           child: Icon(Icons.feedback),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
