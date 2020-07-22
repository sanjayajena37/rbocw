// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressFormModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

//String presentVillage;
//String presentStreet;
//String presentPostOfc;
//String presentState;
//String presentDistrict;
//String presentBlock;
//String presentPanchayat;
//String presentVillageDrop;
//
//String permanentVillage;
//String permanentStreet;
//String permanentPostOfc;
//String permanentState;
//String permanentDistrict;
//String permanentBlock;
//String permanentPanchayat;
//String permanentVillageDrop;
//
//bool isOutOfState=false;
//bool isPermanentPresentSame=false;

AddressShareModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressShareModel()
    ..presentVillage = json['presentVillage'] as String
    ..presentStreet = json['presentStreet'] as String
    ..presentPostOfc = json['presentPostOfc'] as String
    ..presentState = json['presentState'] as String
    ..presentDistrict = json['presentDistrict'] as String
    ..presentBlock = json['presentBlock'] as String
    ..presentPanchayat = json['presentPanchayat'] as String
    ..presentVillageDrop = json['presentVillageDrop'] as String
    
    ..permanentVillage = json['permanentVillage'] as String
    ..permanentStreet = json['permanentStreet'] as String
    ..permanentPostOfc = json['permanentPostOfc'] as String
    ..permanentState = json['permanentState'] as String
    ..permanentDistrict = json['permanentDistrict'] as String
    ..permanentBlock = json['permanentBlock'] as String
    ..permanentDistrict = json['permanentDistrict'] as String
    ..permanentPanchayat = json['permanentPanchayat'] as String
    ..permanentVillageDrop = json['permanentVillageDrop'] as String
    ..isOutOfState = json['isOutOfState'] as bool
    ..isPermanentPresentSame = json['isPermanentPresentSame'] as bool;
}

Map<String, dynamic> _$AddressFormModelToJson(
    AddressShareModel instance) =>
    <String, dynamic>{
      'presentVillage': instance.presentVillage,
      'presentStreet': instance.presentStreet,
      'presentPostOfc': instance.presentPostOfc,
      'presentState': instance.presentState,
      'presentDistrict': instance.presentDistrict,
      'presentBlock': instance.presentBlock,
      'presentPanchayat': instance.presentPanchayat,
      'presentVillageDrop': instance.presentVillageDrop,
      
      'permanentVillage': instance.permanentVillage,
      'permanentStreet': instance.permanentStreet,
      'permanentPostOfc': instance.permanentPostOfc,
      'permanentState': instance.permanentState,
      'permanentDistrict': instance.permanentDistrict,
      'permanentBlock': instance.permanentBlock,
      'permanentPanchayat': instance.permanentPanchayat,
      'permanentVillageDrop': instance.permanentVillageDrop,
      'isOutOfState': instance.isOutOfState,
      'isPermanentPresentSame': instance.isPermanentPresentSame,
    };
