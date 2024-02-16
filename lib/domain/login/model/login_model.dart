import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginModel {
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  LoginModel({required this.accessToken});

  String accessToken;

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
