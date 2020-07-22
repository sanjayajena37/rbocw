import 'package:json_annotation/json_annotation.dart';
part 'nomineeModel.g.dart';

@JsonSerializable()
class NomineeModel {
  String name;
  String address;
  String relation;
  String gender;
  String age;
  String share;
  NomineeModel({this.name, this.address, this.relation,this.gender,this.age,this.share});

  factory NomineeModel.fromJson(Map<String, dynamic> data) =>
      _$NomineeModelFromJson(data);

  Map<String, dynamic> toJson() => _$NomineeModelToJson(this);
}
