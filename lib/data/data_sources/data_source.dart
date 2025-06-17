// ignore_for_file: unused_field


import '../data_sources/http_client/dio_client.dart';
import 'http_client/http_client.dart';
import 'local_storage/share_preference/share_preference_provider.dart';

class DataSource {
  DataSource(this.dio, this.sharedPreferences, this.http);

  final DioClient dio;
  final SharePreferenceProvider sharedPreferences;
  final HttpClient http;
}
