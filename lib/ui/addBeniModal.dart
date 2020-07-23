import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rbocw/models/nomineeModel.dart';
import 'package:rbocw/providers/app_data.dart';

class AddBenificiaryModal extends StatefulWidget {
  final NomineeModel nomineeModel;
  final String title;
  final int share;
  AddBenificiaryModal({Key key, this.nomineeModel, this.title, this.share})
      : super(key: key);

  @override
  _AddBenificiaryModalState createState() => _AddBenificiaryModalState();
}

class _AddBenificiaryModalState extends State<AddBenificiaryModal> {
  String selectedRelation = "";
  String selectedName = "";
  String selectedGender = "";
  List<String> relationStatus = ["Father", "Mother", "Brother", "Sister"];
  List<String> genderList = ["Male", "Female", "Transgender"];
  TextEditingController _name = new TextEditingController();
  TextEditingController _age = new TextEditingController();
  TextEditingController _share = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  NomineeModel nomineeModel = NomineeModel();
  final _beniForm = GlobalKey<FormState>();
  bool _autovalidate = false;
  @override
  void initState() {
    setMemberData();
    super.initState();
  }

  setMemberData() {
    setState(() {
      _name.text = widget.nomineeModel.name;
      _address.text = widget.nomineeModel.address;
      _age.text = widget.nomineeModel.age;
      _share.text = widget.nomineeModel.share;
      selectedGender = widget.nomineeModel.gender;
      selectedRelation = widget.nomineeModel.relation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _beniForm,
        autovalidate: _autovalidate,
        child: Container(
          // width: 300.0,
          decoration: BoxDecoration(
              // color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Text(
                          widget.title,
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              beniFormFieldContainer(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _dismissModal();
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: AppData.kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _dismissModal() {
    if (_name.text == null || _name.text == '') {
      AppData.showToastMessage("Enter name", Colors.red);
    } else if (_address.text == null || _address.text == '') {
      AppData.showToastMessage("Enter address", Colors.red);
    } else if (selectedRelation == null || selectedRelation == '') {
      AppData.showToastMessage("Enter relation", Colors.red);
    } else if (selectedGender == null || selectedGender == '') {
      AppData.showToastMessage("Enter gender", Colors.red);
    } else if (_age.text == null || _age.text == '') {
      AppData.showToastMessage("Enter age", Colors.red);
    } else if (_share.text == null || _share.text == '') {
      AppData.showToastMessage("Enter share %", Colors.red);
    } else {
      _beniForm.currentState.save();
      nomineeModel.name = _name.text;
      nomineeModel.age = _age.text;
      nomineeModel.share = _share.text;
      nomineeModel.address = _address.text;
      nomineeModel.gender = selectedGender;
      nomineeModel.relation = selectedRelation;
      if (int.parse(nomineeModel.share) + widget.share <= 100) {
        print(nomineeModel.name);
        Navigator.pop(context, nomineeModel);
      } else {
        AppData.showToastMessage(
            "Please change share % between 0 to ${100 - widget.share}",
            Colors.red);
        return false;
      }
    }
    // print(_beniForm.currentState.validate());
    // if (_beniForm.currentState.validate()) {

    //   Navigator.pop(context, nomineeModel);

    // }
  }

  Widget beniFormFieldContainer() {
    return Column(
      children: <Widget>[
        inputFieldContainer(name()),
        inputFieldContainer(address()),
        relationShipDropDown(),
        genderDropDown(),
        inputFieldContainer(age()),
        inputFieldContainer(share()),
      ],
    );
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

  TextFormField age() {
    return TextFormField(
      controller: _age,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(2),
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Age",
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value.isEmpty) {
          // AppData.showToastMessage("Enter age");
          return null;
        }
        return null;
      },
      onSaved: (value) {
        _age.text = value;
      },
    );
  }

  TextFormField share() {
    return TextFormField(
      controller: _share,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(2),
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Share(%)",
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value.isEmpty) {
          // AppData.showToastMessage("Enter share");
          return null;
        }
        return null;
      },
      onSaved: (value) {
        _share.text = value;
      },
    );
  }

  TextFormField name() {
    return TextFormField(
      controller: _name,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Name",
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value.isEmpty) {
          // AppData.showToastMessage("Enter name");
          return null;
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _name.text = value;
        });
      },
    );
  }

  TextFormField address() {
    return TextFormField(
      controller: _address,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Address",
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value.isEmpty) {
          // AppData.showToastMessage("Enter Age");
          return null;
        }
        return null;
      },
      onSaved: (value) {
        _address.text = value;
      },
    );
  }

  Widget relationShipDropDown() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
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
                    borderSide: BorderSide(color: Colors.white))),
            value: selectedRelation != '' ? selectedRelation : null,
            hint: Text("Select Relation"),
            onChanged: (value) {
              setState(() {
                selectedRelation = value;
              });
            },
            validator: (value) {
              if (value == null) {
                // selectedRelation == ''
                //     ? AppData.showToastMessage("Enter relation")
                //     : null;

                return null;
              } else {
                return null;
              }
            },
            items: relationStatus.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }

  Widget genderDropDown() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
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
                    borderSide: BorderSide(color: Colors.white))),
            value: selectedGender != '' ? selectedGender : null,
            hint: Text("Select Gender"),
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
            validator: (value) {
              if (value == null) {
                // selectedGender == ''
                //     ? AppData.showToastMessage("Enter gender")
                //     : null;

                return null;
              } else {
                return null;
              }
            },
            items: genderList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }
}
