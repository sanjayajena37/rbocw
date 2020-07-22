// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experienceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpeienceModel _$ExpeienceModelFromJson(Map<String, dynamic> json) {
  return ExpeienceModel(
    establish: json['establish'] as String,
    address: json['address'] as String,
    fromDate: json['fromDate'] as String,
    toDate: json['toDate'] as String,
  );
}

Map<String, dynamic> _$ExpeienceModelToJson(ExpeienceModel instance) =>
    <String, dynamic>{
      'establish': instance.establish,
      'address': instance.address,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
