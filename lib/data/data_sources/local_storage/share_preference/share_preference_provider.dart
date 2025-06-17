import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharePreferenceProvider>(
  (ref) => throw UnimplementedError(),
);

class SharePreferenceProvider {
  SharePreferenceProvider(this._preferences);

  final SharedPreferences _preferences;

  String? getString(String key) => _preferences.getString(key);

  Future<bool> setString(String key, String value) =>
      _preferences.setString(key, value);
}
