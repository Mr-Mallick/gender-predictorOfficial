import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double initialrad = 30.0;

  double rad = 0.0;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_radius_in = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_radius_out = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          rad = animation_radius_in.value * initialrad;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          rad = animation_radius_out.value * initialrad;
        }
      });
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          // Color(0xffFF5C5C),
          Color(0xffFC8EA6),
          Color(0xffE75C4A),
          // Color(0xffFC8EA6),
          Color(0xffC98861),
        ])),
        child: Center(
          child: Container(
            width: 120.0,
            height: 120.0,
            child: Center(
              child: RotationTransition(
                turns: animation_rotation,
                child: Stack(
                  children: <Widget>[
                    Dot(
                      radius: 25.0,
                      // color: Color(0xffe05c0b),
                      color: Colors.white,
                    ),

                    // Container(
                    //     child: Center(
                    //         child: Image.asset(
                    //   "images/tyre1.jpeg",
                    //   height: 45.0,
                    //   width: 45.0,
                    // ))),

                    Transform.translate(
                      offset: Offset(rad * cos(pi / 4), rad * sin(pi / 4)),
                      child: Dot(
                        radius: 7.0,
                        color: Color(0xffE10A0A),
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(rad * cos(2 * pi / 4), rad * sin(2 * pi / 4)),
                      child: Dot(
                        radius: 7.0,
                        // color: Color(0xff9Eca45),
                        color: Colors.white,
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(rad * cos(3 * pi / 4), rad * sin(3 * pi / 4)),
                      child: Dot(
                        radius: 7.0,
                        color: Color(0xffffd800),
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(rad * cos(4 * pi / 4), rad * sin(4 * pi / 4)),
                      child: Dot(
                        radius: 7.0,
                        // color: Color(0xff337ab7),
                        color: Colors.white,
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(rad * cos(5 * pi / 4), rad * sin(5 * pi / 4)),
                      child: Dot(
                        radius: 7.0,
                        color: Color(0xffE10A0A),
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(rad * cos(6 * pi / 4), rad * sin(6 * pi / 4)),
                      child: Dot(
                        radius: 7.0,
                        // color: Color(0xff9Eca45),
                        color: Colors.white,
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(rad * cos(7 * pi / 4), rad * sin(7 * pi / 4)),
                      child: Dot(
                        radius: 7.0,
                        color: Color(0xffffd800),
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(rad * cos(8 * pi / 4), rad * sin(8 * pi / 4)),
                      child: Dot(
                        radius: 7.0,
                        // color: Color(0xff337ab7),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
