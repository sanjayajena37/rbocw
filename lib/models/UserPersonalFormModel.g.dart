// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserPersonalFormModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPersonalFormModel _$UserPersonalFormModelFromJson(
    Map<String, dynamic> json) {
  return UserPersonalFormModel()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..sex = json['sex'] as String
    ..maritalStatus = json['maritalStatus'] as String
    ..fatherName = json['fatherName'] as String
    ..dob = json['dob'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..aadharNo = json['aadharNo'] as String
    ..ageProof = json['ageProof'] as String
    ..member = (json['member'] as List)
        ?.map((e) =>
            e == null ? null : MemberModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserPersonalFormModelToJson(
        UserPersonalFormModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'sex': instance.sex,
      'maritalStatus': instance.maritalStatus,
      'fatherName': instance.fatherName,
      'dob': instance.dob,
      'phoneNumber': instance.phoneNumber,
      'aadharNo': instance.aadharNo,
      'ageProof': instance.ageProof,
      'member': instance.member?.map((e) => e?.toJson())?.toList(),
    };
