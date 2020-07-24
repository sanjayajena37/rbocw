import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rbocw/pages/login.dart';
import 'package:rbocw/scoped-model/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isLogin = false;
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
                          "assets/icons/logo1.png",
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
                        "assets/icons/bow-logo.png",
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
                  "assets/images/footer.jpg",
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
    // Timer(
    //   Duration(seconds: 3),
    //   () => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => LoginScreen(
    //         model: model,
    //       ),
    //     ),
    //   ),
    // );
    Timer(Duration(seconds: 3), navigationPage);
  }

  void navigationPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLogin = (preferences.getBool('IS_LOGINED') ?? false);
    print("isLogin>>>>>" + isLogin.toString());
    if (isLogin) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
    // Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }
}
