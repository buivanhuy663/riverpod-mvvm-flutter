import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/foundation.dart';
// import 'package:universal_html/html.dart' as html;

class NetworkHelper {
  NetworkHelper._();

  static Future<bool> checkConnectivity({required String baseUrl}) async {
    // var isOnLine = html.window.navigator.onLine;
    // if (kIsWeb) {
    //   if (isOnLine == null) {
    //     return false;
    //   } else {
    //     return isOnLine;
    //   }
    // }

    var isOnLine = true;
    final connectivityResult = await Connectivity().checkConnectivity();
    // This condition is for demo purposes only to explain every connection type.
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      isOnLine = false;
    }
    if (isOnLine) {
      try {
        final url = Uri.parse(baseUrl);
        final result = await InternetAddress.lookup(url.host);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    }
    return isOnLine;
  }
}
