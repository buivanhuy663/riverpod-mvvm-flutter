import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../view/resources/resources.dart';

class ErrorHelper {
  ErrorHelper._();

  static String getError(BuildContext context, Object? error) {
    var errorMessage = '';
    final unknownError = AppText.of(context)?.unknown_error ?? 'Unknown error occurred';
    if (error is DioException) {
      final type = error.type;
      if (type case DioExceptionType.connectionTimeout) {
        errorMessage = AppText.of(context)?.timeout_error ?? 'Connection timeout';
      } else if (type case DioExceptionType.connectionError) {
        errorMessage = AppText.of(context)?.network_error ?? 'Network error';
      } else {
        errorMessage = AppText.of(context)?.unknown_error ?? 'Unknown error DioException';
      }
    } else if (error is Exception) {
      errorMessage = error.toString();
    } else {
      errorMessage = unknownError;
    }
    return errorMessage;
  }
}
