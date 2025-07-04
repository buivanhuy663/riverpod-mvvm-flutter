import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../view/resources/resources.dart';

class ErrorHelper {
  ErrorHelper._();

  static String getError(BuildContext context, Object? error) {
    var errorMessage = '';
    final unknownError = context.strings.unknown_error;
    if (error is DioException) {
      final type = error.type;
      if (type case DioExceptionType.connectionTimeout) {
        errorMessage = context.strings.timeout_error;
      } else if (type case DioExceptionType.connectionError) {
        errorMessage = context.strings.network_error;
      } else {
        errorMessage = context.strings.unknown_error;
      }
    } else if (error is Exception) {
      errorMessage = error.toString();
    } else {
      errorMessage = unknownError;
    }
    return errorMessage;
  }
}
