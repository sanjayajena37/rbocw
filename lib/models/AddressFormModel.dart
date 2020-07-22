import 'package:json_annotation/json_annotation.dart';
import 'package:rbocw/models/experienceModel.dart';
import 'package:rbocw/models/memberModel.dart';
import 'package:rbocw/models/nomineeModel.dart';
part 'AddressFormModel.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressShareModel {
  
  String presentVillage;
  String presentStreet;
  String presentPostOfc;
  String presentState;
  String presentDistrict;
  String presentBlock;
  String presentPanchayat;
  String presentVillageDrop;

  String permanentVillage;
  String permanentStreet;
  String permanentPostOfc;
  String permanentState;
  String permanentDistrict;
  String permanentBlock;
  String permanentPanchayat;
  String permanentVillageDrop;
  
  bool isOutOfState=false;
  bool isPermanentPresentSame=false;
  
  AddressShareModel();

  factory AddressShareModel.fromJson(Map<String, dynamic> data) =>
      _$AddressModelFromJson(data);

  Map<String, dynamic> toJson() => _$AddressFormModelToJson(this);

  
}
