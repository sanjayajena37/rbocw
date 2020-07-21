import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rbocw/models/UserPersonalFormModel.dart';
import 'package:rbocw/models/memberModel.dart';
import 'package:rbocw/pages/addmemberForm.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';

class PersonalForm extends StatefulWidget {
  final Function(int, bool) updateTab;
  const PersonalForm({Key key, @required this.updateTab}) : super(key: key);
  @override
  PersonalFormState createState() => PersonalFormState();
}

class PersonalFormState extends State<PersonalForm> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  TextEditingController _firstName = new TextEditingController();
  TextEditingController _lastname = new TextEditingController();
  TextEditingController _fatherName = new TextEditingController();
  TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _aadharNumber = new TextEditingController();

  SharedPref sharedPref = SharedPref();
  UserPersonalFormModel userPersonalForm = UserPersonalFormModel();
  MemberModel memberModel = new MemberModel();
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

  List<AddMemberForm> members = [];

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

  @override
  void initState() {
    setPersonalFormData();
    super.initState();
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
          var _member = MemberModel();
          int index = i;
          _member = userPersonalForm.member[i];
          print("add form call");
          members.add(AddMemberForm(
            member: _member,
            index: index,
            onDelete: () => onDelete(_member),
          ));
        }
      }
      //      var _member = MemberModel();
      // int index = members.length;
      // print("add form call");
      // members.add(AddMemberForm(
      //   member: _member,
      //   index: index,
      //   onDelete: () => onDelete(_member),
      // ));
      setState(() {
        _firstName.text = userPersonalForm.firstName;
        _lastname.text = userPersonalForm.lastName;
        _date.text = userPersonalForm.dob;
        _fatherName.text = userPersonalForm.fatherName;
        _aadharNumber.text = userPersonalForm.aadharNo;
        _phoneNumber.text = userPersonalForm.phoneNumber;
        selectedAgeProof = userPersonalForm.ageProof;
        selectedSex = userPersonalForm.sex;
        selectedMaritalStatus = userPersonalForm.maritalStatus;
      });
    } else {
      print("data not save yet!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(5),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  // backgroundImage: NetworkImage(
                  //   "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                  // ),
                  child: ClipOval(
                    child: new SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: (_image != null)
                          ? Image.file(
                              _image,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  radius: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        getImage();
                      }),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              autovalidate: _autovalidate,
              child: Column(
                children: <Widget>[
                  inputFieldContainer(firstName()),
                  firstNameError
                      ? errorMsg("Please enter first name")
                      : Container(),
                  inputFieldContainer(lastName()),
                  lastNameError
                      ? errorMsg("Please enter Last name")
                      : Container(),
                  sexDropDown(),
                  sexError ? errorMsg("Please select sex") : Container(),
                  maritalStatusDropDown(),
                  maritalError
                      ? errorMsg("Please select mariatal status")
                      : Container(),
                  inputFieldContainer(fatherName()),
                  fatherError
                      ? errorMsg("Please enter father name")
                      : Container(),
                  dob(),
                  dobError ? errorMsg("Please enter dob ") : Container(),
                  mobileNumber(),
                  phoneNoError
                      ? errorMsg("Please enter mobile bumber")
                      : Container(),
                  inputFieldContainer(aadharNumber()),
                  aadharError
                      ? errorMsg("Please enter aadhar number")
                      : Container(),
                  ageProofDropDown(),
                  ageProofError
                      ? errorMsg("Please select age proof")
                      : Container(),
                  familyMember(),
                  continueButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget familyMember() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "Add Family Member",
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

        // Column(
        //   children: <Widget>[
        //     inputFieldContainer(lastName()),
        //     lastNameError ? errorMsg("Please enter name") : Container(),
        //     dob(),
        //     dobError ? errorMsg("Please enter dob ") : Container(),
        //     sexDropDown(),
        //     sexError ? errorMsg("Please select relation") : Container(),
        //   ],
        // )
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
          // setState(() {});
          firstNameError = true;
          return null;
          // return 'Please enter first name';
        } else {
          firstNameError = false;
          return null;
        }
        // return null;
      },
      onSaved: (value) {
        userPersonalForm.firstName = value;
      },
    );
  }

  TextFormField lastName() {
    return TextFormField(
      controller: _lastname,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Last name.",
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (value) {
        if (value.isEmpty) {
          lastNameError = true;

          return null;
        }
        lastNameError = false;
        return null;
      },
      onSaved: (value) {
        userPersonalForm.lastName = value;
      },
    );
  }

  Widget sexDropDown() {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
          // height: 50s,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppData.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            value: selectedSex != '' ? selectedSex : null,
            hint: Text("Select"),
            onChanged: (salutation) {
              setState(() => selectedSex = salutation);
              userPersonalForm.sex = selectedSex;
            },
            validator: (value) {
              print("value" + value.toString());
              print("selectedSex>>" + selectedSex.toLowerCase());
              if (value == null) {
                selectedSex == '' ? sexError = true : sexError = false;
                return null;
              }
              sexError = false;
              return null;
            },
            // validator: (value) => value == null ? 'field required' : null,
            items: sex.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
          // DropdownButtonHideUnderline(
          //   child: DropdownButton<String>(
          //     hint: Text("Select"),
          //     value: selectedSex != '' ? selectedSex : null,
          //     isDense: true,
          //     isExpanded: true,
          //     onChanged: (newValue) {
          //       setState(() {
          //         selectedSex = newValue;
          //       });
          //       print(selectedSex);
          //     },
          //     items: sex.map((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),
          ),
    );
  }

  Widget maritalStatusDropDown() {
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
                    borderSide: BorderSide(color: Colors.white))),
            value: selectedMaritalStatus != '' ? selectedMaritalStatus : null,
            hint: Text("Select"),
            onChanged: (value) {
              setState(() => selectedMaritalStatus = value);
              userPersonalForm.maritalStatus = selectedMaritalStatus;
            },
            validator: (value) {
              if (value == null) {
                // maritalError = true;
                selectedMaritalStatus == ''
                    ? maritalError = true
                    : maritalError = false;
                return null;
              } else {
                maritalError = false;
                return null;
              }
            },
            items: maritalStatus.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }

  Widget ageProofDropDown() {
    return Padding(
//        padding: const EdgeInsets.all(8.0),
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
            value: selectedAgeProof != '' ? selectedAgeProof : null,
            hint: Text("Select"),
            onChanged: (value) {
              setState(() => selectedAgeProof = value);
              userPersonalForm.ageProof = selectedAgeProof;
            },
            validator: (value) {
              if (value == null) {
                // ageProofError = true;
                selectedAgeProof == ''
                    ? ageProofError = true
                    : ageProofError = false;
                return null;
              } else {
                ageProofError = false;
                return null;
              }
            },
            items: ageProof.map((Map value) {
              return DropdownMenuItem<String>(
                value: value['id'],
                child: Text(value['name']),
              );
            }).toList(),
          ),
        ));
  }

  TextFormField fatherName() {
    return TextFormField(
      controller: _fatherName,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Father's/Husband name",
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (value) {
        if (value.isEmpty) {
          fatherError = true;
          return null;
          // return "Please enter Father's/Husband  name";
        }
        fatherError = false;
        return null;
      },
      onSaved: (value) {
        userPersonalForm.fatherName = value;
      },
    );
  }

  Widget mobileNumber() {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppData.kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  // hint: Text("Select Device"),
                  value: AppData.currentSelectedValue,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      AppData.currentSelectedValue = newValue;
                    });
                    print(AppData.currentSelectedValue);
                  },
                  items: AppData.phoneFormat.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              height: 35.0,
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            new Expanded(
              child: TextFormField(
                controller: _phoneNumber,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText: "Phone number",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    // return 'Please enter phone number';
                    phoneNoError = true;
                    return null;
                  }
                  phoneNoError = false;
                  return null;
                },
                onSaved: (value) {
                  userPersonalForm.phoneNumber = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField aadharNumber() {
    return TextFormField(
      controller: _aadharNumber,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Aadhar number.",
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (value) {
        if (value.isEmpty) {
          aadharError = true;
          return null;
          // return 'Please enter aadhar number';
        }
        aadharError = false;
        return null;
      },
      onSaved: (value) {
        userPersonalForm.aadharNo = value;
      },
    );
  }

  Widget dob() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
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
                userPersonalForm.dob = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  dobError = true;
                  return null;
                  // return 'Please enter aadhar number';
                }
                dobError = false;
                return null;
              },
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

  ///on add form
  void onAddForm() {
    setState(() {
      var _member = MemberModel();
      int index = members.length;
      print("add form call");
      members.add(AddMemberForm(
        member: _member,
        index: index,
        onDelete: () => onDelete(_member),
      ));
    });
  }

  ///on form user deleted
  void onDelete(MemberModel _member) {
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
        List<MemberModel> m = [];
        members.forEach((form) {
          allValid = allValid && form.isValid();
          m.add(form.member);
        });
        if (allValid) {
          print("valid" + allValid.toString());

          userPersonalForm.member = m;
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
