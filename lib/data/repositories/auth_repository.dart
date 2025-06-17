import '../data_sources/data_source.dart';
import '../data_sources/local_storage/share_preference/share_preference_key.dart';
import '../models/auth/login_request_model.dart';
import '../models/auth/login_response_model.dart';

class AuthRepository {
  AuthRepository(
    this._dataSource,
  );

  final DataSource _dataSource;

  Future<LoginResponseModel> login(
    LoginRequestModel loginRequest,
  ) async {
    final response = await _dataSource.http.login(loginRequest);
    return response;
  }

  bool saveTokenToLocalStorage(String accessToken) {
    _dataSource.sharedPreferences.setString(SharePreferenceKey.accessToken, accessToken);
    return true;
  }

  String? getAccessToken() =>
      _dataSource.sharedPreferences.getString(SharePreferenceKey.accessToken);
}
