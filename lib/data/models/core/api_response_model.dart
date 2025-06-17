import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponseModel<M> {
  const ApiResponseModel({
    this.success,
    this.data,
    this.message,
    this.error,
    this.forceLogout,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    M Function(Object?) fromJsonM,
  ) => _$ApiResponseModelFromJson<M>(json, fromJsonM);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'data')
  final M? data;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'error')
  final String? error;

  @JsonKey(name: 'forceLogout')
  final bool? forceLogout;

  Map<String, dynamic> toJson(
    ApiResponseModel<M> instance,
    Object? Function(M value) toJsonM,
  ) => _$ApiResponseModelToJson(instance, toJsonM);
}
