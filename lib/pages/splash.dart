import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rbocw/pages/login.dart';
import 'package:rbocw/scoped-model/main.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => SplashScreen(),
      //'/home': (context) => LoginScreen(model: ,model),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  final MainModel model;

  const SplashScreen({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callResourceTimer(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/odisha_logo.png",
                          fit: BoxFit.cover,
                          width: 140.0,
                          height: 140.0,
                        ),
                      ),
                      onTap: () {
                        //  callResourceTimer();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Image.asset(
                        "assets/images/owb_logo.png",
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                        height: 120.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.only(bottom: 8.0),
//              child: Align(
//                alignment: Alignment.bottomCenter,
//                child: Text("Powered by: Nirmalya labs PVT LTD"),
//              ),
//            )
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/bg_down.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void callResourceTimer(MainModel model) {
    //Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, '/home'));
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(
            model: model,
          ),
        ),
      ),
    );
  }
}
