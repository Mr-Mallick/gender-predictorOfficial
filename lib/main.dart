import 'package:flutter/material.dart';
import './interface.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FirstPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // brightness: Brightness.dark,
          primaryColor: Color(0xffE75C4A),
          accentColor: Color(0xffFF5C5C),
        ));
  }
}
