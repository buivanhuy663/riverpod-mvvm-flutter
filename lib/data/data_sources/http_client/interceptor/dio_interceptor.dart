import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../main/dependence.dart';
import '../../../../presentation/resources/resources.dart';
import '../../../../utilities/helpers/network_helper.dart';
import '../../../models/core/api_response_model.dart';
import '../../../repositories/repository.dart';
import '../api_constants.dart';

class DioInterceptor extends QueuedInterceptorsWrapper {
  DioInterceptor();

  bool isAuthenticatedPath(RequestOptions options) =>
      !ApiConstants.nonAuthenticatedPaths.contains(options.path);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await NetworkHelper.checkConnectivity(baseUrl: options.baseUrl);
    if (!isConnected) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: AppText.get?.network_error,
        ),
      );
      return;
    }

    final accessToken = injector.read(repositoryProvider).auth.getAccessToken();
    if (isAuthenticatedPath(options)) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Accept-Encoding': 'gzip, deflate, br, zstd',
      'Accept-Language': 'vi',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json;charset=UTF-8',
    };
    options.headers.addAll(headers);

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_isResponseNotFromServer(response)) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: Response(
            statusCode: HttpStatus.misdirectedRequest,
            requestOptions: response.requestOptions,
          ),
        ),
      );
    }
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    if (isAuthenticatedPath(requestOptions)) {
      // Handle expired AccessToken
      final response = err.response;
      if (response != null && response.statusCode == HttpStatus.unauthorized) {
        if (_isForceLogout(response)) {
          await _logout();
          handler.next(err);
          return;
        }
        try {
          // Try get new AccessToken using refresh token
          // final refreshedAccessToken = await _refreshAccessTokenIfNeeded(
          //   requestOptions,
          // );

          // Retry the original request
          // final retryRequest = await _retryRequest(
          //   refreshedAccessToken,
          //   requestOptions,
          // );
          // handler.resolve(retryRequest);
        } catch (_) {
          await _logout();
          handler.next(err);
        }
        return;
      }
    }
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      handler.next(
        DioException(
          requestOptions: requestOptions,
          error: AppText.get?.timeout_error,
        ),
      );
      return;
    }
    final isConnected = await NetworkHelper.checkConnectivity(
      baseUrl: requestOptions.baseUrl,
    );
    if (!isConnected) {
      handler.next(
        DioException(
          requestOptions: err.requestOptions,
          error: AppText.get?.network_error,
        ),
      );
      return;
    }
    if (_isResponseNotFromServer(err.response)) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: Response(
            statusCode: HttpStatus.misdirectedRequest,
            requestOptions: err.requestOptions,
          ),
        ),
      );
      return;
    }
    handler.next(err);
  }

  Future<void> _logout() async {
  }

  /// [_isForceLogout] is true
  /// when the user is deleted, not the token is wrong or expired.
  /// Then we will logout without calling refresh token and retry request.
  bool _isForceLogout(response) {
    final dataError = ApiResponseModel.fromJson(
      response.data is String ? jsonDecode(response.data) : response.data,
      (p0) => null,
    );
    return dataError.forceLogout ?? false;
  }

  //// [_isResponseNotFromServer] will check if the response returned is from server api,
  //// if not from server api then we will return status code: 421 and show system error message
  //// because in fact there are some cases, the error returns from CDN, VPN but not from the backend server,
  //// the error returns status code: 200 but the response body is not in the correct format, leading to the wrong logic code.
  //// So we need to handle this case to group these special errors into a certain error message.
  //// If you want this functionality to work, then we need to ask the backend team to add the "x-api-response" param to the response headers,
  //// the above param needs to apply all the api that the app uses.
  bool _isResponseNotFromServer(Response? response) => false;
  // !(response?.headers['x-api-response'].toString().contains('true') ??
  //     false);
}
