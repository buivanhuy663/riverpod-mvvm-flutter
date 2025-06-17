import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoHelper {
  DeviceInfoHelper._();

  static DeviceInfoPlugin get deviceInfo => DeviceInfoPlugin();

  static String get platform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'ios';
    } else {
      return 'web';
    }
  }

  static Future<String?> get platformVersion async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return (await deviceInfo.androidInfo).version.release;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return (await deviceInfo.iosInfo).systemVersion;
    }
    return 'unknown';
  }

  static Future<String> get appVersion async => PackageInfo.fromPlatform()
      .then(
        (packageInfo) => packageInfo.version
            .replaceAll('-production', '')
            .replaceAll('-staging', '')
            .replaceAll('-development', ''),
      )
      .onError((error, stackTrace) => '0.0.0');

  static Future<String?> get device async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return (await deviceInfo.androidInfo).model;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return (await deviceInfo.iosInfo).utsname.machine;
    }
    return 'unknown';
  }
}
