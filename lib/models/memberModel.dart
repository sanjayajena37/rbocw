import 'package:json_annotation/json_annotation.dart';
part 'memberModel.g.dart';

@JsonSerializable()
class MemberModel {
  String name;
  String dob;
  String relation;
  MemberModel({this.name, this.dob, this.relation});

  factory MemberModel.fromJson(Map<String, dynamic> data) =>
      _$MemberModelFromJson(data);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
