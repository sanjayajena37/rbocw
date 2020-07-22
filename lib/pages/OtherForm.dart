import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rbocw/pages/nominalPage.dart';
import 'package:rbocw/providers/SharedPref.dart';
import 'package:rbocw/providers/app_data.dart';
import 'dart:io';

import '../providers/app_data.dart';
import 'CustomSignature.dart';

class OtherForm extends StatefulWidget {
  final Function(int, bool) updateTab;

  OtherForm({Key key, @required this.updateTab}) : super(key: key);

  @override
  OtherFormState createState() => OtherFormState();
}

class OtherFormState extends State<OtherForm> {
  final _formKey2 = GlobalKey<FormState>();
  bool _autovalidate = false;
  SharedPref sharedPref = SharedPref();
  bool bplError = false;
  bool pfError = false;
  bool acError = false;
  bool branchError = false;
  bool ifscError = false;
  bool micrError = false;

  File _imageSignature;
  File _imageCertificate;

/////Switch erroe
  bool isMagnera = false;
  bool isPhysical = false;
  bool isMigrant = false;
  bool visiblePresent = false;

  List<String> castList = ["SC", "ST", "SEBC"];
  bool castError = false;
  String selectCast = "";

  List<String> qualifiedList = ["10th", "UG", "GRADUATE", "PG"];
  bool qualifiedError = false;
  String selectQualified = "";

  List<String> nJobList = [
    "Nature Job 1",
    "Nature Job 2",
    "Nature Job 3",
    "Nature Job 4"
  ];
  bool nJobError = false;
  String selectNJob = "";

  List<String> bankList = ["Bank 1", "Bank 2", "Bank 3", "Bank 4"];
  bool bankError = false;
  String selectBank = "";

  List<String> certifiedList = [
    "Certified 1",
    "Certified 2",
    "Certified 3",
    "Certified 4"
  ];
  bool certificateError = false;
  String selectCertificate = "";

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
  List<Offset> _points = <Offset>[];

  //TextEditingController _firstName = new TextEditingController();

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
              //////Nature Of Job
              dynamicDropDown(
                  nJobError, selectNJob, nJobList, "Select Nature of Job"),
              nJobError ? errorMsg("Please select Job Nature") : Container(),

              SizedBox(
                height: 10.0,
              ),
              //////Magnera
              IsMagneraButton(),
              SizedBox(
                height: 5.0,
              ),

              //////Educational Qualification
              dynamicDropDown(qualifiedError, selectQualified, qualifiedList,
                  "Select Educational Qualification"),
              qualifiedError
                  ? errorMsg("Please select Qualification")
                  : Container(),

              ///////BPL/Anadaya
              inputFieldContainer(
                  reuseTextField("BPL/Antyodaya Card No", bplError)),
              bplError ? errorMsg("Please enter BPL/Antyodaya") : Container(),

              ///////PF/ESI
              inputFieldContainer(
                  reuseTextField("BPL/Antyodaya Card No If Any", pfError)),
              pfError ? errorMsg("Please enter PF/ESI No If Any") : Container(),

              //////SC/ST
              dynamicDropDown(castError, selectCast, castList, "Select Cast"),
              castError ? errorMsg("Please select Qualification") : Container(),

              SizedBox(
                height: 15.0,
              ),
              IsMinerSwitchButton(),
              SizedBox(
                height: 15.0,
              ),
              MigrantWorkerSwitchButton(),
              SizedBox(
                height: 10.0,
              ),

              //////Bank Name
              dynamicDropDown(bankError, selectBank, bankList, "Select bank"),
              bankError ? errorMsg("Please select Qualification") : Container(),

              ///////PF/ESI
              inputFieldContainer(reuseTextField("Account Number", acError)),
              acError
                  ? errorMsg("Please enter Account number")
                  : Container(), ///////PF/ESI
              inputFieldContainer(reuseTextField("Branch Number", branchError)),
              branchError
                  ? errorMsg("Please enter Branch name")
                  : Container(), ///////PF/ESI
              inputFieldContainer(reuseTextField("IFSC Number", ifscError)),
              ifscError
                  ? errorMsg("Please enter IFSC number")
                  : Container(), ///////PF/ESI
              inputFieldContainer(reuseTextField("MICR Number", micrError)),
              micrError ? errorMsg("Please enter MICR number") : Container(),

              Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
                child: Text(
                  "Select Signature",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      getSignatureImage();
                    },
                    child: Text("Select Signature"),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Signature(),
                          ));
                    },
                    child: Text("Capture Signature"),
                  )
                ],
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Certified that the above applicant is / was engaged by me / known to me as a building workers since .",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),

              dynamicDropDown(certificateError, selectCertificate,
                  certifiedList, "Select Certified By"),
              certificateError
                  ? errorMsg("Please select Certificated BY")
                  : Container(),

              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Copy of employee certificate",
                    style: TextStyle(fontSize: 17.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      getCerificateImage();
                    },
                    child: Text("Certificate"),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
                child: Text(
                  "Registration Fee Details",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 5.0, bottom: 10.0),
                child: Text(
                  "₹ 20",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),

              //continueButton(),
              nextButton()
            ],
          ),
        )
      ],
    );
  }

  Widget IsMagneraButton() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 8.0),
          child: Text(
            "Is MGNREGA?",
            style: TextStyle(
                //    fontSize: 18.0,
                ),
          ),
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
            value: isMagnera,
            onToggle: (valuePress) {
              setState(() {
                isMagnera = valuePress;
              });
            },
          ),
        ),
      ],
    );
  }

  Future getSignatureImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);

    setState(() {
      _imageSignature = image;

      print('Image Path $_imageSignature');
    });
  }

  Future getCerificateImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);

    setState(() {
      _imageCertificate = image;

      print('Image Path $_imageCertificate');
    });
  }

  Widget IsMinerSwitchButton() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Whether Minority/Physically Challenged/ET?",
              style: TextStyle(
                  //fontSize: 16.0,
                  ),
            )),
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: FlutterSwitch(
            height: 28.0,
            width: 45.0,
            padding: 4.0,
            toggleSize: 15.0,
            borderRadius: 15.0,
            activeColor: AppData.kPrimaryColor,
            //showOnOff: true,
            value: isMagnera,
            onToggle: (valuePress) {
              setState(() {
                isMagnera = valuePress;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget MigrantWorkerSwitchButton() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 10.0, right: 8.0),
            child: Text(
              "Whether Interstate migrant worker?",
              style: TextStyle(
                  //fontSize: 18.0,
                  ),
            )),
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: FlutterSwitch(
            height: 28.0,
            width: 45.0,
            padding: 4.0,
            toggleSize: 15.0,
            borderRadius: 15.0,
            activeColor: AppData.kPrimaryColor,
            //showOnOff: true,
            value: isMigrant,
            onToggle: (valuePress) {
              setState(() {
                isMigrant = valuePress;
              });
            },
          ),
        ),
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

  Widget nextButton() {
    return new InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => NomineePage(),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
        child: new Container(
          //width: 100.0,
          height: 45.0,
          decoration: new BoxDecoration(
            color: AppData.kPrimaryColor,
            //border: new Border.all(color: Colors.white, width: 2.0),
            borderRadius: new BorderRadius.circular(17.0),
          ),
          child: new Center(
            child: new Text(
              'Next Step',
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  addressFormvalidate() {
    _formKey2.currentState.validate();
    print("address validation call" + nJobError.toString());
    if (!nJobError) {
      _formKey2.currentState.save();
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
//
//class SignaturePainter extends CustomPainter {
//  SignaturePainter(this.points);
//
//  final List<Offset> points;
//
//  void paint(Canvas canvas, Size size) {
//    Paint paint = new Paint()
//      ..color = Colors.black
//      ..strokeCap = StrokeCap.round
//      ..strokeWidth = 5.0;
//    for (int i = 0; i < points.length - 1; i++) {
//      if (points[i] != null && points[i + 1] != null)
//        canvas.drawLine(points[i], points[i + 1], paint);
//    }
//  }
//
//  bool shouldRepaint(SignaturePainter other) => other.points != points;
//}
