import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rbocw/providers/app_data.dart';
import 'package:rbocw/scoped-model/main.dart';
import 'package:rbocw/widgets/rounded_button.dart';
import 'package:rbocw/widgets/rounded_input_field.dart';

class RegisterPage extends StatefulWidget {
  final MainModel model;

  const RegisterPage({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var categorySelected = 0;
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
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25),
                SvgPicture.asset(
                  "assets/icons/govt_logo.svg",
                  height: size.height * 0.18,
                ),
                SizedBox(height: 10),
                Text(
                  "Wel Come Back!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCategoryItem(0, "Existing User", context),
                      _buildCategoryItem(1, "New User", context),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                categorySelected == 0
                    ? Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            RoundedInputField(
                                hintText: "Please Enter Registration no.",
                                icon: Icons.phone,
                                textField: false,
                                // textAction: false,
                                onChanged: (value) {},
                                onSubmitted: (value) {
                                  print(">>>>>>>>>>>>>>>." + value);
                                }),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 2),
                                  width: size.width * 0.8,
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
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: AppData.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            RoundedButton(
                              text: "Ok",
                              press: () {},
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCategoryItem(index, text, context) {
    Size size = MediaQuery.of(context).size;
    return new InkWell(
      onTap: () {
        setSelectedItem(index);
        print("click");
      },
      child: Container(
        width: size.width / 2.5,
        // margin: new EdgeInsets.only(left: 10.0, right: 10),
        child: new Material(
          elevation: 2.0,
          color: categorySelected == index
              ? Colors.greenAccent.shade200
              : Colors.grey,
          borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
          child: new Container(
            padding: new EdgeInsets.only(
                left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
            child: new Text(
              text,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color:
                      categorySelected == index ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  void setSelectedItem(index) {
    if (index != categorySelected) {
      setState(() {
        categorySelected = index;
      });
    }
  }
}
