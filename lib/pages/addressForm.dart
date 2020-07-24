import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rbocw/models/AddressFormModel.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

import '../models/UserPersonalFormModel.dart';
import '../providers/app_data.dart';

class AddressForm extends StatefulWidget {
  final Function(int, bool) updateTab;

  bool isConfirmPage;
  bool isFromDash;

  AddressForm({Key key, @required this.updateTab, this.isConfirmPage, this.isFromDash})
      : super(key: key);

  @override
  AddressFormState createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  final _formKey1 = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  SharedPref sharedPref = SharedPref();
  AddressShareModel _addModel = AddressShareModel();
  bool villageError = false;
  bool villageError1 = false;
  bool streatError = false;
  bool streatError1 = false;
  bool postOfcError = false;
  bool postOfcError1 = false;

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

  TextEditingController _village = new TextEditingController();
  TextEditingController _street = new TextEditingController();
  TextEditingController _office = new TextEditingController();

  TextEditingController _streetP = new TextEditingController();
  TextEditingController _villageP = new TextEditingController();
  TextEditingController _officeP = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAddressFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
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
                inputFieldContainer(reuseTextField(
                    "Village/Town", villageError, "Village", _village)),
                villageError
                    ? errorMsg("Please enter village/town")
                    : Container(),

                ///////Street
                inputFieldContainer(
                    reuseTextField("Street", streatError, "Street", _street)),
                streatError ? errorMsg("Please enter Street") : Container(),

                ///////Post office
                inputFieldContainer(reuseTextField(
                    "Post Office", postOfcError, "postOfc", _office)),
                postOfcError ? errorMsg("Please enter Post Office") : Container(),

                //////State
                dynamicDropDown(
                    stateError, selectState, statesList, "Select State", "state"),
                stateError ? errorMsg("Please select state") : Container(),

                //////District
                dynamicDropDown(districtError, selectDistrict, districtList,
                    "Select District", "district"),
                districtError ? errorMsg("Please select district") : Container(),

                //////Block
                dynamicDropDown(
                    blockError, selectBlock, blockList, "Select Block", "block"),
                blockError ? errorMsg("Please select district") : Container(),

                //////Panchyat
                dynamicDropDown(panchayatError, selectPanchayat, panchayatList,
                    "Select Panchayat", "panchayat"),
                panchayatError ? errorMsg("Please select district") : Container(),

                //////Village
                dynamicDropDown(villageDError, selectVillageD, villageList,
                    "Select Village", "village"),
                villageDError ? errorMsg("Please select district") : Container(),

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
                inputFieldContainerVisiblity(reuseTextField(
                    "Village/Town", villageError1, "pVillage", _villageP)),
                villageError1
                    ? errorMsg("Please enter permanent village/town")
                    : Container(),

                ///////Street
                inputFieldContainerVisiblity(
                    reuseTextField("Street", streatError1, "pStreet", _streetP)),
                streatError1  ? errorMsg("Please enter permanent Street")
                    : Container(),

                ///////Post office
                inputFieldContainerVisiblity(reuseTextField(
                    "Post Office", postOfcError1, "pPofc", _officeP)),
                postOfcError1
                    ? errorMsg("Please enter permanent Post Office")
                    : Container(),

                //////State
                dynamicVisibleDropDown(
                    stateError1, selectState1, statesList, "Select State","state"),
                stateError1 ? errorMsg("Please select state") : Container(),

                //////District
                dynamicVisibleDropDown(districtError1, selectDistrict1,
                    districtList, "Select District","district"),
                districtError1 ? errorMsg("Please select district") : Container(),

                //////Block
                dynamicVisibleDropDown(
                    blockError1, selectBlock1, blockList, "Select Block","block"),
                blockError1 ? errorMsg("Please select district") : Container(),

                //////Panchyat
                dynamicVisibleDropDown(panchayatError1, selectPanchayat1,
                    panchayatList, "Select Panchayat","panchayat"),
                panchayatError1 ? errorMsg("Please select district") : Container(),

                //////Village
                dynamicVisibleDropDown(villageDError1, selectVillageD1,
                    villageList, "Select Village","village"),
                villageDError1 ? errorMsg("Please select district") : Container(),

                continueButton()
              ],
            ),
          )
        ],
      ),
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
                  // fontSize: 18.0,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FlutterSwitch(
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
                _addModel.isOutOfState=valuePress;
              },
            ),
          ),
        ],
      ),
    );
  }

  setAddressFormData() async {
    var addressForm = await sharedPref.getKey("addressForm");

    if (addressForm != null) {
      print("Address Form" + addressForm.toString());
      AddressShareModel shareModel =
      AddressShareModel.fromJson(await sharedPref.read("addressForm"));
//      if (userPersonalForm.member != null) {
//        for (var i = 0; i < userPersonalForm.member.length; i++) {
//          print("userPersonalForm.member>>>>>>>>" +
//              userPersonalForm.member.toString());
//        }
//      }

      setState(() {
        _village.text = shareModel.presentVillage;
        _street.text = shareModel.presentStreet;
        _office.text = shareModel.presentPostOfc;
        selectState = shareModel.presentState;
        selectDistrict = shareModel.presentDistrict;
        selectBlock = shareModel.presentBlock;
        selectPanchayat = shareModel.presentPanchayat;
        selectVillageD = shareModel.presentVillageDrop;
      });
    } else {
      print("data not save yet!");
    }
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
                    //  fontSize: 18.0,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FlutterSwitch(
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
                _addModel.isPermanentPresentSame=valuePress;
              },
            ),
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

  TextFormField reuseTextField(String hint, bool error, String comeFrom,
      TextEditingController controller) {
    return TextFormField(
      controller: controller,
      enabled: widget.isConfirmPage ? false : true,
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
        //_addModel.names = value;
        switch (comeFrom) {
          case "Village":
            _addModel.presentVillage = value;
            break;
          case "Street":
            _addModel.presentStreet = value;
            break;
          case "postOfc":
            _addModel.presentPostOfc = value;
            break;
          case "pVillage":
            _addModel.permanentVillage = value;
            break;
          case "pStreet":
            _addModel.permanentStreet = value;
            break;
          case "pPofc":
            _addModel.permanentPostOfc = value;
            break;
        }
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
          addressFormValidate();
        },
      ),
    );
  }

//  addressFormvalidate() {
//    _formKey1.currentState.validate();
//    print("address validation call" + villageError.toString());
//    if (!villageError) {
//      _formKey1.currentState.save();
//      widget.updateTab(1, true);
//      return true;
//    } else {
//      setState(() {
//        _autovalidate = true; //enable realtime validation
//      });
//      return false;
//    }
//  }

  Widget dynamicDropDown(bool error, String selectData, List<String> dataList,
      String hintText, String callFor) {
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
            //disabledHint:Text(selectData != '' ? selectData : null) ,
            value: selectData != '' ? selectData : null,
            hint: Text(hintText),
            onChanged: (value) {
              setState(() => selectData = value);
              //userPersonalForm.maritalStatus = selectState;
              switch (callFor) {
                case "state":
                  _addModel.presentState = value;
                  break;
                case "district":
                  _addModel.presentDistrict = value;
                  break;
                case "block":
                  _addModel.presentBlock = value;
                  break;
                case "panchayat":
                  _addModel.presentPanchayat = value;
                  break;
                case "village":
                  _addModel.presentVillageDrop = value;
                  break;
              }
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
      bool error, String selectData, List<String> dataList, String hintText,String callFor) {
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
                switch (callFor) {
                  case "state":
                    _addModel.permanentState = value;
                    break;
                  case "district":
                    _addModel.permanentDistrict = value;
                    break;
                  case "block":
                    _addModel.permanentBlock = value;
                    break;
                  case "panchayat":
                    _addModel.permanentPanchayat = value;
                    break;
                  case "village":
                    _addModel.permanentVillageDrop = value;
                    break;
                }
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

  addressFormValidate() async {
    _formKey1.currentState.validate();
    //print("sex>>>>" + selectedSex.toString());

//    if (selectVillageD != '') {
//      userPersonalForm.sex = selectedSex;
//    }
//    if (selectedAgeProof != '') {
//      userPersonalForm.ageProof = selectedAgeProof;
//    }
//    if (selectedMaritalStatus != '') {
//      userPersonalForm.maritalStatus = selectedMaritalStatus;
//    }
    // if (_formKey.currentState.validate()) {
    _formKey1.currentState.save();
    sharedPref.save("addressForm",
        _addModel); //save once fields are valid, onSaved method invoked for every form fields
    // return true;

    print("Address>>>>>" + _addModel.toString());
    widget.updateTab(1, true);
//    if (!villageError &&
//        !streatError &&
//        !postOfcError &&
//        !stateError &&
//        !districtError &&
//        !blockError &&
//        !panchayatError &&
//        !villageDError && !villageDError1 && !panchayatError1 && !blockError1 && !districtError1 && !streatError1 && !postOfcError1 && !stateError1 && !villageError1  ) {
//      //form is valid, proceed further
//      _formKey1.currentState.save();
//      sharedPref.save("addressForm",
//          _addModel); //save once fields are valid, onSaved method invoked for every form fields
//      // return true;
//
//      print("Address>>>>>" + _addModel.toString());
//      widget.updateTab(0, true);
//    } else {
////      setState(() {
////        _autovalidate = true; //enable realtime validation
////      });
//      if(villageError){
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please enter village ")));
//      }else if(streatError){
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please enter Street")));
//      }else if(postOfcError){
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please enter Post Office")));
//      }else if(stateError){
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select State")));
//      }else if(districtError){
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select District")));
//      }else if(blockError){
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select Block")));
//      }else if(panchayatError){
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select Block")));
//      }else if(villageDError){
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select Village Drop Down")));
//      }else if(visiblePresent){
//        if(villageError1){
//          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please enter Permanent Village ")));
//        }else if(streatError1){
//          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please enter Permanent Street")));
//        }else if(postOfcError1){
//          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please enter Permanent Post-office")));
//        }else if(stateError1){
//          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select State")));
//        }else if(districtError1){
//          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select State")));
//        }else if(blockError1){
//          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select State")));
//        }else if(panchayatError1){
//          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select State")));
//        }else if(villageDError1){
//          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please Select State")));
//        }
//      }
//      // return false;
//    }
  }
}
