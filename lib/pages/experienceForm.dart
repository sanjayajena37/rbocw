import 'package:flutter/material.dart';
import 'package:rbocw/models/UserPersonalFormModel.dart';
import 'package:rbocw/models/experienceModel.dart';
import 'package:rbocw/models/memberModel.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

typedef OnDelete();

class ExperienceForm extends StatefulWidget {
  final ExpeienceModel member;
  final int index;
  final state = _ExperienceFormState();
  final OnDelete onDelete;

  ExperienceForm({Key key, this.member, this.onDelete, this.index})
      : super(key: key);

  @override
  _ExperienceFormState createState() => state;

  bool isValid() => state.validate();
}

class _ExperienceFormState extends State<ExperienceForm> {
  final form1 = GlobalKey<FormState>();

  SharedPref sharedPref = SharedPref();
  UserPersonalFormModel userPersonalForm = UserPersonalFormModel();
  MemberModel memberModel = MemberModel();
  String selectedRelation = "";
  List<String> relationStatus = ["Father", "Mother", "Brother", "Sister"];
  DateTime selectedDate = DateTime.now();
  TextEditingController _fromDate = new TextEditingController();
  TextEditingController _toDate = new TextEditingController();
  TextEditingController _establish = new TextEditingController();
  TextEditingController _address = new TextEditingController();

  @override
  void initState() {
    setMemberData();
    super.initState();
  }

  setMemberData() {
    setState(() {
      _fromDate.text = widget.member.fromDate;
      _toDate.text = widget.member.toDate;
      _establish.text = widget.member.establish;
      _address.text = widget.member.address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
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
                    'Work Experience ${widget.index + 1}',
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
          inputFieldContainer(establishName()),
          inputFieldContainer(address()),
          fromDob(),
          toDob(),
          //relationShipDropDown(),
        ],
      ),
    );
  }

  Widget fromDob() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 0.0,bottom: 0.0),
      child: GestureDetector(
        onTap: () => _selectDate(context,_fromDate),
        child: AbsorbPointer(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
              color: AppData.kPrimaryLightColor,
              borderRadius: BorderRadius.circular(29),
            ),
            child: TextFormField(
              controller: _fromDate,
              keyboardType: TextInputType.datetime,
              onSaved: (value) {
                widget.member.fromDate = value;
              },
              validator: (value) {},
              decoration: InputDecoration(
                hintText: 'From date',
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
    );
  }

  Widget toDob() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 0.0,bottom: 0.0),
      child: GestureDetector(
        onTap: () => _selectDate(context,_toDate),
        child: AbsorbPointer(
          child: Container(
            //margin: EdgeInsets.symmetric(vertical: 10),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
              color: AppData.kPrimaryLightColor,
              borderRadius: BorderRadius.circular(29),
            ),
            child: TextFormField(
              controller: _toDate,
              keyboardType: TextInputType.datetime,
              onSaved: (value) {
                widget.member.toDate = value;
              },
              validator: (value) {},
              decoration: InputDecoration(
                hintText: 'To date',
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
    );
  }

  Widget inputFieldContainer(child) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0,bottom: 0.0),
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

  TextFormField establishName() {
    return TextFormField(
      controller: _establish,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Name of Establishment",
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {},
      onSaved: (value) {
        widget.member.establish = value;
      },
    );
  }TextFormField address() {
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

//  Widget relationShipDropDown() {
//    return Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Container(
//          height: 45,
//          padding: EdgeInsets.symmetric(horizontal: 15),
//          decoration: BoxDecoration(
//            color: AppData.kPrimaryLightColor,
//            borderRadius: BorderRadius.circular(29),
//          ),
//          child: DropdownButtonFormField<String>(
//            decoration: InputDecoration(
//                enabledBorder: UnderlineInputBorder(
//                    borderSide: BorderSide(color: Colors.white))),
//            value: selectedRelation != '' ? selectedRelation : null,
//            hint: Text("Select"),
//            onChanged: (value) {
//              setState(() {
//                selectedRelation = value;
//                widget.member.relation = value;
//              });
//            },
//            validator: (value) {},
//            items: relationStatus.map((String value) {
//              return DropdownMenuItem<String>(
//                value: value,
//                child: Text(value),
//              );
//            }).toList(),
//          ),
//        ));
//  }

  Future<Null> _selectDate(BuildContext context,TextEditingController controller) async {
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
    var valid = form1.currentState.validate();
    if (valid) {
      form1.currentState.save();
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
