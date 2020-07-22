// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nomineeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NomineeModel _$NomineeModelFromJson(Map<String, dynamic> json) {
  return NomineeModel(
    name: json['name'] as String,
    address: json['address'] as String,
    relation: json['relation'] as String,
    gender: json['gender'] as String,
    age: json['age'] as String,
    share: json['share'] as String,
  );
}

Map<String, dynamic> _$NomineeModelToJson(NomineeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'relation': instance.relation,
      'gender': instance.gender,
      'age': instance.age,
      'share': instance.share,
    };
