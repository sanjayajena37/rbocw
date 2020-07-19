import 'package:flutter/material.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

class AddressForm extends StatefulWidget {
  final Function(int, bool) updateTab;
  AddressForm({Key key, @required this.updateTab}) : super(key: key);

  @override
  AddressFormState createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  final _formKey1 = GlobalKey<FormState>();
  bool _autovalidate = false;
  SharedPref sharedPref = SharedPref();
  bool firstNameError = false;
  TextEditingController _firstName = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(5),
      children: <Widget>[
        Form(
          key: _formKey1,
          autovalidate: _autovalidate,
          child: Column(
            children: <Widget>[
              inputFieldContainer(firstName()),
              firstNameError
                  ? errorMsg("Please enter first name")
                  : Container(),
              continueButton()
            ],
          ),
        )
      ],
    );
  }

  Widget errorMsg(text) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget inputFieldContainer(child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppData.kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: child,
      ),
    );
  }

  TextFormField firstName() {
    return TextFormField(
      controller: _firstName,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "First name.",
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value.isEmpty) {
          firstNameError = true;
          return null;
          // return 'Please enter first name';
        } else {
          print("kkk");
          firstNameError = false;
          return null;
        }
        // return null;
      },
      onSaved: (value) {
        // userPersonalForm.firstName = value;
      },
    );
  }

  Widget continueButton() {
    return InkWell(
      child: Center(
        child: CircleAvatar(
          radius: 20.0,
          //backgroundColor: Colors.amber.shade600,
          backgroundColor: AppData.kPrimaryColor,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        setState(() {});
        addressFormvalidate();
      },
    );
  }

  addressFormvalidate() {
    _formKey1.currentState.validate();
    print("address validation call" + firstNameError.toString());
    if (!firstNameError) {
      _formKey1.currentState.save();
      widget.updateTab(1, true);
      return true;
    } else {
      setState(() {
        _autovalidate = true; //enable realtime validation
      });
      return false;
    }
  }
}
