import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rbocw/providers/app_data.dart';
import 'package:rbocw/scoped-model/main.dart';
import 'package:rbocw/widgets/phone_number.dart';
import 'package:rbocw/widgets/rounded_input_field.dart';

class ConfirmPage extends StatefulWidget {
  final MainModel model;
  const ConfirmPage({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  bool _isExistinguser = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: body(context),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(
            text: "${picked.day}-${picked.month}-${picked.year}");
      });
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.green.shade200, Colors.green]),
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          SvgPicture.asset(
            "assets/icons/govt_logo.svg",
            height: size.height * 0.18,
          ),
          SizedBox(height: 10),
          !_isExistinguser ? confirmationContaint() : registrationForm()
        ],
      ),
    );
  }

  Widget registrationForm() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Stack(
        children: [
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 350,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  PhoneNumberField(
                    hintText: "Please Enter Phone no.",
                    onSubmitted: (value) {
                      print(">>>>>>>>>>>>>>>." + value);
                    },
                    textAction: true,
                  ),
                  // RoundedInputField(
                  //     hintText: "Please Enter Registration no.",
                  //     icon: Icons.phone,
                  //     textField: false,
                  //     // textAction: false,
                  //     onChanged: (value) {},
                  //     onSubmitted: (value) {
                  //       print(">>>>>>>>>>>>>>>." + value);
                  //     }),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 45,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        // width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: AppData.kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          controller: _date,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'Date of Birth',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: AppData.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: InkWell(
                            child: Icon(
                              Icons.keyboard_backspace,
                              color: Colors.yellow,
                            ),
                            onTap: () => {
                              setState(() {
                                _isExistinguser = false;
                              })
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.amber.shade600,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            height: 370,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Text("OK", style: TextStyle(color: Colors.white70)),
                color: Colors.amber,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget confirmationContaint() {
    return Center(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            children: <Widget>[
              Text(
                "Are you existing use?",
                textScaleFactor: 0.6,
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print("click");
                      setState(() {
                        _isExistinguser = true;
                      });
                    },
                    child: Container(
                      width: 120,
                      // margin: new EdgeInsets.only(left: 10.0, right: 10),
                      child: new Material(
                        elevation: 2.0,
                        color: Colors.blueAccent,
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25.0)),
                        child: new Container(
                          padding: new EdgeInsets.only(
                              left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
                          child: new Text(
                            "YES",
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("click");
                    },
                    child: Container(
                      width: 120,
                      // margin: new EdgeInsets.only(left: 10.0, right: 10),
                      child: new Material(
                        elevation: 2.0,
                        color: Colors.red,
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25.0)),
                        child: new Container(
                          padding: new EdgeInsets.only(
                              left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
                          child: new Text(
                            "NO",
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..quadraticBezierTo(size.width, 0.0, size.width - 20.0, 0.0)
      ..lineTo(40.0, 70.0)
      ..quadraticBezierTo(10.0, 85.0, 0.0, 120.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
