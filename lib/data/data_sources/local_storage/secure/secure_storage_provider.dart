import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageProvider>(
  (ref) => throw UnimplementedError(),
);

class SecureStorageProvider {
  SecureStorageProvider(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> getString(String key) => _secureStorage.read(key: key);

  Future<bool> setString(String key, String value) async {
    bool isOk = false;
    await _secureStorage
        .write(key: key, value: value)
        .onError((error, stackTrace) {
          isOk = false;
        })
        .then((value) {
          isOk = true;
        });
    return isOk;
  }
}
