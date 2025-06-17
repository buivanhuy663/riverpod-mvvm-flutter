import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  LoginResponseModel({
    required this.accessToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;

  // @JsonKey(name: 'refresh_token')
  // final String? refreshToken;

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
