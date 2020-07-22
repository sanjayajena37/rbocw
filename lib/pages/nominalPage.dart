import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rbocw/models/UserPersonalFormModel.dart';
import 'package:rbocw/models/nomineeModel.dart';
import 'package:rbocw/pages/ConfirmPages.dart';
import 'package:rbocw/pages/nomineeForm.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

class NomineePage extends StatefulWidget {
  final Function(int, bool) updateTab;
  const NomineePage({Key key, @required this.updateTab}) : super(key: key);
  @override
  NomineePageState createState() => NomineePageState();
}

class NomineePageState extends State<NomineePage> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();

  SharedPref sharedPref = SharedPref();
  UserPersonalFormModel userPersonalForm = UserPersonalFormModel();
  NomineeModel memberModel = new NomineeModel();
  bool firstNameError = false;
  bool lastNameError = false;
  bool sexError = false;
  bool maritalError = false;
  bool fatherError = false;
  bool dobError = false;
  bool phoneNoError = false;
  bool aadharError = false;
  bool ageProofError = false;

  List<String> sex = ['Male', "Female", "Other"];
  String selectedSex = "";
  List<String> maritalStatus = ["Married", "Single"];
  String selectedMaritalStatus = "";
  List<Map<String, dynamic>> ageProof = [
    {"name": "Voter Id", "id": "1"},
    {"name": "Aadhar Card", "id": "2"}
  ];
  String selectedAgeProof = "";

  List<NomineeForm> members = [];

 

  @override
  void initState() {
    setPersonalFormData();
    super.initState();
    onAddForm();
  }

  setPersonalFormData() async {
    var personalForm = await sharedPref.getKey("userForm");

    if (personalForm != null) {
      print("userPersonalForm" + personalForm.toString());
      UserPersonalFormModel userPersonalForm =
          UserPersonalFormModel.fromJson(await sharedPref.read("userForm"));
      if (userPersonalForm.member != null) {
        for (var i = 0; i < userPersonalForm.member.length; i++) {
          print("userPersonalForm.member>>>>>>>>" +
              userPersonalForm.member.toString());
          var _member = NomineeModel();
          int index = i;
          _member = userPersonalForm.nominee[i];
          print("add form call");
          members.add(NomineeForm(
            member: _member,
            index: index,
            onDelete: () => onDelete(_member),
          ));
        }
      }
      
    } else {
      print("data not save yet!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Step 2/3: Add Nominee",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            children: <Widget>[

              nomineeAdd(),
              nextButton()

            ],
          ),
        ),
      ),
    );
  }

  Widget nomineeAdd() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "Add Nominee",
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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);

    setState(() {
      _image = image;

      print('Image Path $_image');
    });
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
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
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
        personalFormValidate();
      },
    );
  }

  Widget nextButton() {
    return new InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ConfirmPages(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 8.0,right: 8.0),
        child: new Container(
          //width: 100.0,
          height: 45.0,
          decoration: new BoxDecoration(
            color: AppData.kPrimaryColor,
            //border: new Border.all(color: Colors.white, width: 2.0),
            borderRadius: new BorderRadius.circular(17.0),
          ),
          child: new Center(child: new Text('Next Step', style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
        ),
      ),
    );
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _member = NomineeModel();
      int index = members.length;
      print("add form call");
      members.add(NomineeForm(
        member: _member,
        index: index,
        onDelete: () => onDelete(_member),
      ));
    });
  }

  ///on form user deleted
  void onDelete(NomineeModel _member) {
    setState(() {
      var find = members.firstWhere(
        (it) => it.member == _member,
        orElse: () => null,
      );
      if (find != null) members.removeAt(members.indexOf(find));
    });
  }

  personalFormValidate() async {
    _formKey.currentState.validate();
    print("sex>>>>" + selectedSex.toString());
    if (selectedSex != '') {
      userPersonalForm.sex = selectedSex;
    }
    if (selectedAgeProof != '') {
      userPersonalForm.ageProof = selectedAgeProof;
    }
    if (selectedMaritalStatus != '') {
      userPersonalForm.maritalStatus = selectedMaritalStatus;
    }
    // if (_formKey.currentState.validate()) {
    if (!firstNameError &&
        !lastNameError &&
        !sexError &&
        !maritalError &&
        !fatherError &&
        !dobError &&
        !phoneNoError &&
        !aadharError &&
        !ageProofError) {
      //form is valid, proceed further
      _formKey.currentState.save();
      sharedPref.save("userForm",
          userPersonalForm); //save once fields are valid, onSaved method invoked for every form fields
      // return true;
      if (members.length > 0) {
        var allValid = true;
        List<NomineeModel> m = [];
        members.forEach((form) {
          allValid = allValid && form.isValid();
          m.add(form.member);
        });
        if (allValid) {
          print("valid" + allValid.toString());

          userPersonalForm.nominee = m;
        }
      }
      print("members>>>>>" + members.toString());
      widget.updateTab(0, true);
    } else {
      setState(() {
        _autovalidate = true; //enable realtime validation
      });
      // return false;
    }
  }
}
