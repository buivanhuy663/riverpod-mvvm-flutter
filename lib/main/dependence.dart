import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/data_source.dart';
import '../data/data_sources/http_client/dio_client.dart';
import '../data/data_sources/http_client/http_client.dart';
import '../data/data_sources/http_client/interceptor/dio_interceptor.dart';
import '../data/data_sources/local_storage/secure/secure_storage_provider.dart';
import '../data/data_sources/local_storage/share_preference/share_preference_provider.dart';
import '../data/repositories/repository.dart';
import '../view/base/app_lifecycle.dart';
import 'app_flavor.dart';

var injector = ProviderContainer();

class Dependence {
  static Future<ProviderContainer> initDependence(AppFlavor appFlavor) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    dio.interceptors.addAll([
      DioInterceptor(),
      LogInterceptor(),
    ]);

    final dioClient = DioClient(dio, baseUrl: appFlavor.baseUrl);

    final httpClient = HttpClient(appFlavor.baseUrl);

    const secureStorage = FlutterSecureStorage();

    // ignore: join_return_with_assignment
    injector = ProviderContainer(
      overrides: [
        appFlavorProvider.overrideWithValue(appFlavor),

        appLifecycleProvider.overrideWithValue(AppLifecycle()),

        sharedPreferencesProvider.overrideWithValue(
          SharePreferenceProvider(sharedPreferences),
        ),

        secureStorageProvider.overrideWithValue(
          SecureStorageProvider(secureStorage),
        ),

        repositoryProvider.overrideWithValue(
          Repository(
            DataSource(
              dioClient,
              SharePreferenceProvider(sharedPreferences),
              httpClient,
            ),
          ),
        ),
      ],
    );
    return injector;
  }
}
