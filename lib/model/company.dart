import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  Company({this.id, this.name});

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}