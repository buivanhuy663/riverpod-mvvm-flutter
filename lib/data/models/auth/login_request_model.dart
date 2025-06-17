import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  const LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
