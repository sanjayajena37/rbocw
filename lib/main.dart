import 'package:flutter/material.dart';
import 'package:rbocw/pages/confirmPage.dart';
import 'package:rbocw/pages/login.dart';
import 'package:rbocw/pages/newUserRegister.dart';
import 'package:rbocw/pages/register.dart';
import 'package:scoped_model/scoped_model.dart';

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
                primarySwatch: Colors.blue,
              ),
              home: LoginScreen(model: _model),
              // home: RegisterPage(model: _model),
              // home: ConfirmPage(model: _model),
              routes: {
                '/login': ((BuildContext context) =>
                    NewUserRegister(model: model)),
                // '/dashboard': ((BuildContext context) => DashBoard(model)),
              });
        }));
  }
}
