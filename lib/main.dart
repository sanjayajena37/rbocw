import 'package:flutter/material.dart';
import 'package:rbocw/pages/ExistingUser.dart';
import 'package:rbocw/pages/OtpView.dart';
import 'package:rbocw/pages/homePage.dart';
import 'package:rbocw/pages/login.dart';
import 'package:rbocw/pages/newUserRegister.dart';
import 'package:rbocw/pages/register.dart';
import 'package:rbocw/pages/splash.dart';
import 'package:scoped_model/scoped_model.dart';

import 'pages/splash.dart';
import 'scoped-model/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
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
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            //home: NewUserRegister(model: _model),
            home: SplashScreen(model: _model),
            routes: {
              '/login': (context) => LoginScreen(model: _model),
              '/otp': (context) => OtpView(),
              '/existing': (context) => ExistingUser(model: _model),
              '/register': (context) => NewUserRegister(model: _model),
              '/home': (context) => HomePage(model: _model),
            },
            // home: RegisterPage(model: _model),
          );
        }));
  }
}
