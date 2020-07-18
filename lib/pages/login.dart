import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rbocw/pages/OtpView.dart';
import 'package:rbocw/providers/app_data.dart';
import 'package:rbocw/scoped-model/main.dart';
import 'package:rbocw/widgets/phone_number.dart';
import 'package:rbocw/widgets/rounded_input_field.dart';

class LoginScreen extends StatefulWidget {
  // MainModel _model = MainModel();
  // LoginScreen(this._model);

  final MainModel model;
  const LoginScreen({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 40.0, right: 40.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height: 80),
                  SvgPicture.asset(
                    "assets/icons/govt_logo.svg",
                    height: size.height * 0.18,
                  ),
                  SizedBox(height: 10),
                  SvgPicture.asset(
                    "assets/icons/bow-logo.svg",
                    height: size.height * 0.15,
                  ),
                  SizedBox(height: size.height * 0.05),
                  PhoneNumberField(
                    hintText: "Please Enter Phone no.",
                    onSubmitted: (value) {
                      print(">>>>>>>>>>>>>>>." + value);
                      _validateMobileNumber(value, context);
                    },
                    textAction: true,
                  )
                  // RoundedInputField(
                  //     hintText: "Please Enter Phone no.",
                  //     icon: Icons.phone,
                  //     textField: true,
                  //     textAction: true,
                  //     onChanged: (value) {},
                  //     onSubmitted: (value) {
                  //       print(">>>>>>>>>>>>>>>." + value);
                  //       _validateMobileNumber(value, context);
                  //     }),
                ],
              ),
            ),
            widget.model.isLoginLoading
                ? Stack(
                    children: [
                      new Opacity(
                        opacity: 0.1,
                        child: const ModalBarrier(
                            dismissible: false, color: Colors.grey),
                      ),
                      new Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Container()
          ],
        ));
    // return Stack(
    //   children: <Widget>[
    //     Positioned(
    //       top: 0,
    //       left: 0,
    //       child: Image.asset(
    //         "assets/images/main_top.png",
    //         width: size.width * 0.35,
    //       ),
    //     ),
    //     Container(
    //       child: ListView(
    //         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    //         children: <Widget>[
    //           SizedBox(height: 80),
    //           SvgPicture.asset(
    //             "assets/icons/govt_logo.svg",
    //             height: size.height * 0.18,
    //           ),
    //           SizedBox(height: 10),
    //           SvgPicture.asset(
    //             "assets/icons/bow-logo.svg",
    //             height: size.height * 0.15,
    //           ),
    //           SizedBox(height: size.height * 0.05),
    //           RoundedInputField(
    //               hintText: "Please Enter Phone no.",
    //               icon: Icons.phone,
    //               textField: true,
    //               textAction: true,
    //               onChanged: (value) {},
    //               onSubmitted: (value) {
    //                 print(">>>>>>>>>>>>>>>." + value);
    //                 _validateMobileNumber(value, context);
    //               }),
    //         ],
    //       ),
    //     ),
    //     Positioned(
    //       bottom: 0,
    //       right: 0,
    //       child: Image.asset(
    //         "assets/images/login_bottom.png",
    //         width: size.width * 0.4,
    //       ),
    //     ),
    //     model.isLoginLoading
    //         ? Stack(
    //             children: [
    //               new Opacity(
    //                 opacity: 0.1,
    //                 child: const ModalBarrier(
    //                     dismissible: false, color: Colors.grey),
    //               ),
    //               new Center(
    //                 child: new CircularProgressIndicator(),
    //               ),
    //             ],
    //           )
    //         : Container()
    //   ],
    // );
  }

  _validateMobileNumber(String mobileNo, context) async {
    //make api call
    if (mobileNo.length == 10) {
      Map<String, dynamic> response =
          await widget.model.getLoginResponse({"mobile": mobileNo});

      print(response);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => OtpView()));
    } else {
      return false;
    }
  }
}
