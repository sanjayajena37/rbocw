import 'package:json_annotation/json_annotation.dart';
import 'package:rbocw/models/experienceModel.dart';
import 'package:rbocw/models/memberModel.dart';
import 'package:rbocw/models/nomineeModel.dart';
part 'UserPersonalFormModel.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPersonalFormModel {
  String firstName;
  String lastName;
  String sex;
  String maritalStatus;
  String fatherName;
  String dob;
  String phoneNumber;
  String aadharNo;
  String ageProof;
  List<MemberModel> member;
  List<ExpeienceModel> experience;
  List<NomineeModel> nominee;

  UserPersonalFormModel();

  factory UserPersonalFormModel.fromJson(Map<String, dynamic> data) =>
      _$UserPersonalFormModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserPersonalFormModelToJson(this);

  // UserPersonalFormModel.fromJson(Map<String, dynamic> json)
  //     : firstName = json['firstName'],
  //       lastName = json['lastName'],
  //       sex = json['sex'],
  //       maritalStatus = json['maritalStatus'],
  //       fatherName = json['fatherName'],
  //       dob = json['dob'],
  //       phoneNumber = json['phoneNumber'],
  //       aadharNo = json['aadharNo'],
  //       ageProof = json['ageProof'];

  // Map<String, dynamic> toJson() => {
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'sex': sex,
  //       'maritalStatus': maritalStatus,
  //       'fatherName': fatherName,
  //       'dob': dob,
  //       'phoneNumber': phoneNumber,
  //       'aadharNo': aadharNo,
  //       'ageProof': ageProof
  //     };
}
