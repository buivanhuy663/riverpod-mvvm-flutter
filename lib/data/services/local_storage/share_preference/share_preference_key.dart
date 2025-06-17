class SharePreferenceKey {
  SharePreferenceKey._();

  // Auth key
  static const String _prefixAuth = 'auth';
  static const String refreshToken = '${_prefixAuth}_refresh_token';
  static const String accessToken = '${_prefixAuth}_access_token';
}
