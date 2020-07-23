import 'package:flutter/material.dart';
import 'package:rbocw/models/experienceModel.dart';
import 'package:rbocw/pages/experienceForm.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

class WorkExperienceForm extends StatefulWidget {
  final Function(int, bool) updateTab;

  bool isConfirmPage;

  WorkExperienceForm({Key key, @required this.updateTab,this.isConfirmPage}) : super(key: key);

  @override
  WorkExperienceFormState createState() => WorkExperienceFormState();
}

class WorkExperienceFormState extends State<WorkExperienceForm> {
  final _formKey2 = GlobalKey<FormState>();
  bool _autovalidate = false;
  SharedPref sharedPref = SharedPref();
  bool firstNameError = false;

  List<ExperienceForm> members = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onAddForm();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(5),
      children: <Widget>[
        Form(
          key: _formKey2,
          autovalidate: _autovalidate,
          child: Column(
            children: <Widget>[
//              inputFieldContainer(firstName()),
//              firstNameError
//                  ? errorMsg("Please enter first name")
//                  : Container(),
              workExperienceAdd(),
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



  Widget continueButton() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top:8.0),
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
      ),
      onTap: () {
        setState(() {});
        familyMemberFormvalidate();
      },
    );
  }

  Widget workExperienceAdd() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "Work Experience",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: InkWell(
                onTap: onAddForm,
                child: Icon(
                  Icons.add,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        members.length <= 0
            ? Container()
            : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: members.length,
          itemBuilder: (_, i) => members[i],
        ),
      ],
    );
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _member = ExpeienceModel();
      int index = members.length;
      print("add form call");
      members.add(ExperienceForm(
        member: _member,
        index: index,
        onDelete: () => onDelete(_member),
      ));
    });
  }

  ///on form user deleted
  void onDelete(ExpeienceModel _member) {
    setState(() {
      var find = members.firstWhere(
            (it) => it.member == _member,
        orElse: () => null,
      );
      if (find != null) members.removeAt(members.indexOf(find));
    });
  }

  familyMemberFormvalidate() {
    setState(() {});
    _formKey2.currentState.validate();
    if (!firstNameError) {
      _formKey2.currentState.save();
      widget.updateTab(2, true);
      // sharedPref.save("userForm",
      //     userPersonalForm); //save once fields are valid, onSaved method invoked for every form fields
      return true;
    } else {
      setState(() {
        _autovalidate = true; //enable realtime validation
      });
      return false;
    }
  }
}
