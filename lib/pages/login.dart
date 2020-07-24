import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rbocw/pages/OtpView.dart';
import 'package:rbocw/providers/app_data.dart';
import 'package:rbocw/scoped-model/main.dart';
import 'package:rbocw/widgets/phone_number.dart';

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
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  // color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      toBeginningOfSentenceCase("language"),
                      style: TextStyle(
                          color: AppData.kPrimaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // hint: Text("Select Device"),
                        value: AppData.slectedLanguage,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            AppData.slectedLanguage = newValue;
                          });
                          print(AppData.slectedLanguage);
                        },
                        items: AppData.language.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
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
  }

  _validateMobileNumber(String mobileNo, context) async {
    //make api call
    if (mobileNo.length == 10) {
      Map<String, dynamic> response =
          await widget.model.getLoginResponse({"mobile": mobileNo});

      print(response);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) => OtpView()));
      Navigator.of(context).pushNamed('/otp');
    } else {
      return false;
    }
  }
}
