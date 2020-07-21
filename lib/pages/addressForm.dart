import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

import '../providers/app_data.dart';

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
  bool villageError = false;
  bool streatError = false;
  bool postOfcError = false;

  bool visiblePresent = false;
  bool outOfstate = false;

  List<String> statesList = ["ODISHA", "MP", "UP"];
  bool stateError = false;
  String selectState = "";
  bool stateError1 = false;
  String selectState1 = "";

  List<String> districtList = ["CTC", "BBSR", "PURI", "KHORDHA"];
  bool districtError = false;
  String selectDistrict = "";
  bool districtError1 = false;
  String selectDistrict1 = "";

  List<String> blockList = ["BLOCK 1", "BLOCK 2", "BLOCK 3", "BLOCK 4"];
  bool blockError = false;
  String selectBlock = "";
  bool blockError1 = false;
  String selectBlock1 = "";

  List<String> panchayatList = [
    "Panchayat 1",
    "Panchayat 2",
    "Panchayat 3",
  ];
  bool panchayatError = false;
  String selectPanchayat = "";
  bool panchayatError1 = false;
  String selectPanchayat1 = "";

  List<String> villageList = [
    "Village 1",
    "Village 2",
    "Village 3",
    "Village 3"
  ];
  bool villageDError = false;
  String selectVillageD = "";
  bool villageDError1 = false;
  String selectVillageD1 = "";

  TextEditingController _firstName = new TextEditingController();

  //TextEditingController _firstName = new TextEditingController();

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
              /////////////Present Address
              Align(
                child: Text(
                  "Present Address",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      color: Colors.black),
                ),
                alignment: Alignment.topLeft,
              ),

              ///////Village/Town
              inputFieldContainer(reuseTextField("Village/Town", villageError)),
              villageError
                  ? errorMsg("Please enter village/town")
                  : Container(),

              ///////Street
              inputFieldContainer(reuseTextField("Street", streatError)),
              villageError ? errorMsg("Please enter Street") : Container(),

              ///////Post office
              inputFieldContainer(reuseTextField("Post Office", postOfcError)),
              villageError ? errorMsg("Please enter Post Office") : Container(),

              //////State
              dynamicDropDown(
                  stateError, selectState, statesList, "Select State"),
              districtError ? errorMsg("Please select state") : Container(),

              //////District
              dynamicDropDown(districtError, selectDistrict, districtList,
                  "Select District"),
              districtError ? errorMsg("Please select district") : Container(),

              //////Block
              dynamicDropDown(
                  blockError, selectBlock, blockList, "Select Block"),
              districtError ? errorMsg("Please select district") : Container(),

              //////Panchyat
              dynamicDropDown(panchayatError, selectPanchayat, panchayatList,
                  "Select Panchayat"),
              districtError ? errorMsg("Please select district") : Container(),

              //////Village
              dynamicDropDown(
                  villageDError, selectVillageD, villageList, "Select Village"),
              districtError ? errorMsg("Please select district") : Container(),

              SizedBox(
                height: 20.0,
              ),
              /////////////Permanent Address
              Align(
                child: Text(
                  "Permanent Address",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      color: Colors.black),
                ),
                alignment: Alignment.topLeft,
              ),

//              SwitchButton("If beneficiary is out of state? ",outOfstate),
//              SwitchButton("If same as present address click yes? ",visiblePresent),
              outStateSwitchButton(),
              presentAddSwitchButton(),

              ///////Village/Town
              inputFieldContainerVisiblity(
                  reuseTextField("Village/Town", villageError)),
              villageError
                  ? errorMsg("Please enter permanent village/town")
                  : Container(),

              ///////Street
              inputFieldContainerVisiblity(
                  reuseTextField("Street", streatError)),
              villageError
                  ? errorMsg("Please enter permanent Street")
                  : Container(),

              ///////Post office
              inputFieldContainerVisiblity(
                  reuseTextField("Post Office", postOfcError)),
              villageError
                  ? errorMsg("Please enter permanent Post Office")
                  : Container(),

              //////State
              dynamicVisibleDropDown(
                  stateError1, selectState1, statesList, "Select State"),
              districtError ? errorMsg("Please select state") : Container(),

              //////District
              dynamicVisibleDropDown(districtError1, selectDistrict1,
                  districtList, "Select District"),
              districtError ? errorMsg("Please select district") : Container(),

              //////Block
              dynamicVisibleDropDown(
                  blockError1, selectBlock1, blockList, "Select Block"),
              districtError ? errorMsg("Please select district") : Container(),

              //////Panchyat
              dynamicVisibleDropDown(panchayatError1, selectPanchayat1,
                  panchayatList, "Select Panchayat"),
              districtError ? errorMsg("Please select district") : Container(),

              //////Village
              dynamicVisibleDropDown(villageDError1, selectVillageD1,
                  villageList, "Select Village"),
              districtError ? errorMsg("Please select district") : Container(),

              continueButton()
            ],
          ),
        )
      ],
    );
  }

  Widget outStateSwitchButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "If beneficiary is out of state?",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              )),
          FlutterSwitch(
            height: 28.0,
            width: 45.0,
            padding: 4.0,
            toggleSize: 15.0,
            borderRadius: 15.0,
            activeColor: AppData.kPrimaryColor,
            value: outOfstate,
            onToggle: (valuePress) {
              setState(() {
                outOfstate = valuePress;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget presentAddSwitchButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "If same as present address click yes? ",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                )),
          ),
          FlutterSwitch(
            height: 28.0,
            width: 45.0,
            padding: 4.0,
            toggleSize: 15.0,
            borderRadius: 15.0,
            activeColor: AppData.kPrimaryColor,
            //showOnOff: true,
            value: visiblePresent,
            onToggle: (valuePress) {
              setState(() {
                visiblePresent = valuePress;
              });
            },
          ),
        ],
      ),
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
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
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

  Widget inputFieldContainerVisiblity(child) {
    return Visibility(
      visible: (visiblePresent) ? false : true,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppData.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: child,
        ),
      ),
    );
  }

  TextFormField reuseTextField(String hint, bool error) {
    return TextFormField(
      //controller: _firstName,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value.isEmpty) {
          error = true;
          return null;
          // return 'Please enter first name';
        } else {
          print("kkk");
          error = false;
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
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: InkWell(
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
          // setState(() {});
          addressFormvalidate();
        },
      ),
    );
  }

  addressFormvalidate() {
    _formKey1.currentState.validate();
    print("address validation call" + villageError.toString());
    if (!villageError) {
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

  Widget dynamicDropDown(
      bool error, String selectData, List<String> dataList, String hintText) {
    return Padding(
        //padding: const EdgeInsets.all(8.0),
        padding:
            const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
        child: Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppData.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            value: selectData != '' ? selectData : null,
            hint: Text(hintText),
            onChanged: (value) {
              setState(() => selectData = value);
              //userPersonalForm.maritalStatus = selectState;
            },
            validator: (value) {
              if (value == null) {
                // maritalError = true;
                selectData == '' ? error = true : error = false;
                return null;
              } else {
                error = false;
                return null;
              }
            },
            items: dataList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }

  Widget dynamicVisibleDropDown(
      bool error, String selectData, List<String> dataList, String hintText) {
    return Visibility(
      visible: (visiblePresent) ? false : true,
      child: Padding(
          //padding: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(
              top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
          child: Container(
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppData.kPrimaryLightColor,
              borderRadius: BorderRadius.circular(29),
            ),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              value: selectData != '' ? selectData : null,
              hint: Text(hintText),
              onChanged: (value) {
                setState(() => selectData = value);
                //userPersonalForm.maritalStatus = selectState;
              },
              validator: (value) {
                if (value == null) {
                  // maritalError = true;
                  selectData == '' ? error = true : error = false;
                  return null;
                } else {
                  error = false;
                  return null;
                }
              },
              items: dataList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )),
    );
  }
}
