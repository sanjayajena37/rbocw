import 'package:json_annotation/json_annotation.dart';
part 'experienceModel.g.dart';

@JsonSerializable()
class ExpeienceModel {
  String establish;
  String address;
  String fromDate;
  String toDate;
  ExpeienceModel({this.establish, this.address, this.fromDate,this.toDate});

  factory ExpeienceModel.fromJson(Map<String, dynamic> data) =>
      _$ExpeienceModelFromJson(data);

  Map<String, dynamic> toJson() => _$ExpeienceModelToJson(this);
}
