import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rbocw/models/UserPersonalFormModel.dart';
import 'package:rbocw/models/experienceModel.dart';
import 'package:rbocw/models/memberModel.dart';
import 'package:rbocw/models/nomineeModel.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

typedef OnDelete();

class NomineeForm extends StatefulWidget {
  final NomineeModel member;
  final int index;
  final state = _NomineeFormState();
  final OnDelete onDelete;

  NomineeForm({Key key, this.member, this.onDelete, this.index})
      : super(key: key);

  @override
  _NomineeFormState createState() => state;

  bool isValid() => state.validate();
}

class _NomineeFormState extends State<NomineeForm> {
  final form2 = GlobalKey<FormState>();

  SharedPref sharedPref = SharedPref();
  UserPersonalFormModel userPersonalForm = UserPersonalFormModel();
  NomineeModel memberModel = NomineeModel();
  String selectedRelation = "";
  String selectedName = "";
  String selectedGender = "";
  List<String> nameList = ["Father", "Mother", "Brother", "Sister"];
  List<String> relationStatus = ["Father", "Mother", "Brother", "Sister"];
  List<String> genderList = ["Male", "Female", "Transgender"];
  DateTime selectedDate = DateTime.now();

  TextEditingController _age = new TextEditingController();
  TextEditingController _share = new TextEditingController();
  TextEditingController _address = new TextEditingController();

  @override
  void initState() {
    setMemberData();
    super.initState();
  }

  setMemberData() {
    setState(() {
      _address.text = widget.member.address;
      _age.text = widget.member.age;
      _share.text = widget.member.share;
      selectedRelation = widget.member.relation;
      selectedName = widget.member.name;
      selectedGender = widget.member.gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFF255E55),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Nominee Beneficiary ${widget.index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
          nameDropDown(),
          inputFieldContainer(address()),
          relationShipDropDown(),
          genderDropDown(),
          inputFieldContainer(age()),
          inputFieldContainer(share()),
          //relationShipDropDown(),
        ],
      ),
    );
  }

//  Widget fromDob() {
//    return Padding(
//      //padding: const EdgeInsets.symmetric(horizontal: 8),
//      padding:
//          const EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0, bottom: 0.0),
//      child: GestureDetector(
//        onTap: () => _selectDate(context, _fromDate),
//        child: AbsorbPointer(
//          child: Container(
//            margin: EdgeInsets.symmetric(vertical: 10),
//            height: 45,
//            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//            // width: size.width * 0.8,
//            decoration: BoxDecoration(
//              color: AppData.kPrimaryLightColor,
//              borderRadius: BorderRadius.circular(29),
//            ),
//            child: TextFormField(
//              controller: _fromDate,
//              keyboardType: TextInputType.datetime,
//              onSaved: (value) {
//                widget.member.fromDate = value;
//              },
//              validator: (value) {},
//              decoration: InputDecoration(
//                hintText: 'From date',
//                border: InputBorder.none,
//                contentPadding: EdgeInsets.symmetric(vertical: 14),
//                prefixIcon: Icon(
//                  Icons.calendar_today,
//                  size: 18,
//                  color: AppData.kPrimaryColor,
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }


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
      validator: (value) {},
      onSaved: (value) {
        widget.member.age = value;
      },
    );
  }TextFormField share() {
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
      validator: (value) {},
      onSaved: (value) {
        widget.member.share = value;
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
      validator: (value) {},
      onSaved: (value) {
        widget.member.address = value;
      },
    );
  }

  Widget nameDropDown() {
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
            value: selectedName != '' ? selectedName : null,
            hint: Text("Select Name"),
            onChanged: (value) {
              setState(() {
                selectedName = value;
                widget.member.name = value;
              });
            },
            validator: (value) {},
            items: nameList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
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
                widget.member.relation = value;
              });
            },
            validator: (value) {},
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
                widget.member.gender = value;
              });
            },
            validator: (value) {},
            items: genderList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }

  Future<Null> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        controller.value = TextEditingValue(
            text: "${picked.day}-${picked.month}-${picked.year}");
      });
  }

  ///form validator
  bool validate() {
    var valid = form2.currentState.validate();
    if (valid) {
      form2.currentState.save();
      // memberModel.name = _name.text;
      // memberModel.dob = _date.text;
      // memberModel.relation = selectedRelation;
      print("relation>>>>>>>>>" + memberModel.relation.toString());
      // List<MemberModel> m = [];
      // m.add(memberModel);
      // sharedPref.save("members", m);
      return valid;
    }
  }
}
