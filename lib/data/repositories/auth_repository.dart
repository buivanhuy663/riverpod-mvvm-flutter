import '../models/auth/login_request_model.dart';
import '../models/auth/login_response_model.dart';
import '../services/local_storage/local_storage_key.dart';
import '../services/services.dart';

class AuthRepository {
  AuthRepository(this._services);

  final Services _services;

  Future<LoginResponseModel> login(LoginRequestModel loginRequest) async {
    final response = await _services.http.login(loginRequest);
    return response;
  }

  bool saveTokenToLocalStorage(String accessToken) {
    _services.sharedPreference.setString(
      LocalStorageKey.accessToken,
      accessToken,
    );
    return true;
  }

  String? getAccessToken() =>
      _services.sharedPreference.getString(LocalStorageKey.accessToken);
}
