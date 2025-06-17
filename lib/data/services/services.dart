// ignore_for_file: unused_field

import 'http_client/dio_client.dart';
import 'http_client/http_client.dart';
import 'local_storage/secure_storage.dart';
import 'local_storage/share_preference.dart';

class Services {
  Services(this.dio, this.http, this.sharedPreference, this.secureStorage);

  final DioClient dio;
  final HttpClient http;

  final SharePreference sharedPreference;
  final SecureStorage secureStorage;
}
