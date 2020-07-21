// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) {
  return MemberModel()
    ..name = json['name'] as String
    ..dob = json['dob'] as String
    ..relation = json['relation'] as String;
}

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dob': instance.dob,
      'relation': instance.relation,
    };
