import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data_sources/http_client/api_constants.dart';

final appFlavorProvider = Provider<AppFlavor>(
  (ref) => AppFlavor(appFlavorType: AppFlavorType.development, baseUrl: ''),
);

enum AppFlavorType { development, production }

class AppFlavor {
  AppFlavor({required this.appFlavorType, required this.baseUrl});

  final AppFlavorType appFlavorType;
  final String baseUrl;
}

class AppFlavorValue {
  static final AppFlavor development = AppFlavor(
    appFlavorType: AppFlavorType.development,
    baseUrl: ApiConstants.devBaseUrl,
  );

  static final AppFlavor production = AppFlavor(
    appFlavorType: AppFlavorType.production,
    baseUrl: ApiConstants.prodBaseUrl,
  );
}
