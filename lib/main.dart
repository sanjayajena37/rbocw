import 'package:flutter/material.dart';
import 'package:rbocw/pages/ExistingUser.dart';
import 'package:rbocw/pages/OtpView.dart';
import 'package:rbocw/pages/homePage.dart';
import 'package:rbocw/pages/login.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'scoped-model/main.dart';

bool isLogin = false;
Future main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  isLogin = (preferences.getBool('IS_LOGINED') ?? false);
  runApp(MyApp(isLogin));
}

class MyApp extends StatefulWidget {
  final bool isLogin;
  MyApp(this.isLogin);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: _model,
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return MaterialApp(
            title: 'RBOCW',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: !widget.isLogin
                ? LoginScreen(
                    model: _model,
                  )
                : HomePage(
                    model: _model,
                  ),
            // initialRoute: !widget.isLogin ? '/' : '/home',
            routes: {
              '/login': (context) => LoginScreen(
                    model: _model,
                  ),
              '/otp': (context) => OtpView(),
              '/existing': (context) => ExistingUser(),
              '/home': (context) => HomePage(
                    model: _model,
                  ),
            },
          );
        }));
  }
}
