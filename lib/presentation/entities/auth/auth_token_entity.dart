import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token_entity.freezed.dart';

@freezed
sealed class AuthTokenEntity with _$AuthTokenEntity {
  const factory AuthTokenEntity({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required double expiresIn,
  }) = _AuthTokenEntity;

  const AuthTokenEntity._();

  // bool get hasValidAccessToken => accessToken.isNotEmpty;

  // bool get hasValidRefreshToken => refreshToken.isNotEmpty;
}
