import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRequest {
  LoginRequest(
      {required this.username,
      required this.password,
      required this.authProviderId});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  final String username;
  final String password;
  final String authProviderId;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginRequest &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password &&
          authProviderId == other.authProviderId;

  @override
  int get hashCode =>
      username.hashCode ^ password.hashCode ^ authProviderId.hashCode;
}
