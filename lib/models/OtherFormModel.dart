import 'package:json_annotation/json_annotation.dart';
import 'package:rbocw/models/experienceModel.dart';
import 'package:rbocw/models/memberModel.dart';
import 'package:rbocw/models/nomineeModel.dart';
part 'OtherFormModel.g.dart';

@JsonSerializable(explicitToJson: true)
class OtherFormModel {
  
  String natureOfJob;
  bool isMagnera=false;
  String qualification;
  String bplAntdya;
  String esiPf;
  String cast;
  bool isPhysicalChallenge=false;
  bool isMigrantWorkker=false;
  String bank;
  String accountNo;
  String branch;
  String ifsc;
  String micr;
  String cerifiedBy;
  String signatureImagePath;
  
  OtherFormModel();

  factory OtherFormModel.fromJson(Map<String, dynamic> data) =>
      _$AddressModelFromJson(data);

  Map<String, dynamic> toJson() => _$AddressFormModelToJson(this);

  
}
