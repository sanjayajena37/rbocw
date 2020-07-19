class UserPersonalForm {
  String firstName;
  String lastName;
  String sex;
  String maritalStatus;
  String fatherName;
  String dob;
  String phoneNumber;
  String aadharNo;
  String ageProof;

  UserPersonalForm();

  UserPersonalForm.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        sex = json['sex'],
        maritalStatus = json['maritalStatus'],
        fatherName = json['fatherName'],
        dob = json['dob'],
        phoneNumber = json['phoneNumber'],
        aadharNo = json['aadharNo'],
        ageProof = json['ageProof'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'sex': sex,
        'maritalStatus': maritalStatus,
        'fatherName': fatherName,
        'dob': dob,
        'phoneNumber': phoneNumber,
        'aadharNo': aadharNo,
        'ageProof': ageProof
      };
}
