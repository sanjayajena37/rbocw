import 'package:flutter/material.dart';
import 'package:rbocw/models/UserPersonalFormModel.dart';
import 'package:rbocw/models/memberModel.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

typedef OnDelete();

class AddMemberForm extends StatefulWidget {
  final MemberModel member;
  final int index;
  final state = _AddMemberFormState();
  final OnDelete onDelete;

  AddMemberForm({Key key, this.member, this.onDelete, this.index})
      : super(key: key);
  @override
  _AddMemberFormState createState() => state;

  bool isValid() => state.validate();
}

class _AddMemberFormState extends State<AddMemberForm> {
  final form = GlobalKey<FormState>();

  SharedPref sharedPref = SharedPref();
  UserPersonalFormModel userPersonalForm = UserPersonalFormModel();
  MemberModel memberModel = MemberModel();
  String selectedRelation = "";
  List<String> relationStatus = ["Father", "Mother", "Brother", "Sister"];
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  TextEditingController _name = new TextEditingController();

  @override
  void initState() {
    setMemberData();
    super.initState();
  }

  setMemberData() {
    setState(() {
      _name.text = widget.member.name;
      _date.text = widget.member.dob;
      selectedRelation = widget.member.relation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(29),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Family member ${widget.index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
            ),
          ),
          inputFieldContainer(name()),
          dob(),
          relationShipDropDown(),
        ],
      ),
    );
  }

  Widget dob() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
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
              controller: _date,
              keyboardType: TextInputType.datetime,
              onSaved: (value) {
                widget.member.dob = value;
              },
              validator: (value) {},
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
    );
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
      validator: (value) {},
      onSaved: (value) {
        widget.member.name = value;
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
            hint: Text("Select"),
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

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) {
      form.currentState.save();
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
