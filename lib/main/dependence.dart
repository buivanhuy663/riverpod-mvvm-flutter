import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/repository.dart';
import '../data/services/http_client/dio_client.dart';
import '../data/services/http_client/http_client.dart';
import '../data/services/http_client/interceptor/dio_interceptor.dart';
import '../data/services/local_storage/secure_storage.dart';
import '../data/services/local_storage/share_preference.dart';
import '../data/services/services.dart';
import '../view/base/app_lifecycle.dart';
import 'app_flavor.dart';

var injector = ProviderContainer();

class Dependence {
  static Future<ProviderContainer> initDependence(AppFlavor appFlavor) async {
    final appLifecycle = AppLifecycle();

    final sharedPreference = SharePreference(
      await SharedPreferences.getInstance(),
    );

    final dioClient = DioClient(
      Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
        ),
      )..interceptors.addAll([DioInterceptor(), LogInterceptor()]),
      baseUrl: appFlavor.baseUrl,
    );

    final httpClient = HttpClient(appFlavor.baseUrl);

    final secureStorage = SecureStorage(const FlutterSecureStorage());

    // ignore: join_return_with_assignment
    return ProviderContainer(
      overrides: [
        appFlavorProvider.overrideWithValue(appFlavor),

        appLifecycleProvider.overrideWithValue(appLifecycle),

        repositoryProvider.overrideWithValue(
          Repository(
            Services(dioClient, httpClient, sharedPreference, secureStorage),
          ),
        ),
      ],
    );
  }
}
