import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../utils/helpers/logger_helper.dart';

class LoggerInterceptor extends Interceptor {
  LoggerInterceptor({
    this.requestHeader = true,
    this.requestBody = true,
    this.responseBody = true,
    this.responseHeader = true,
    this.error = true,
    this.maxWidth = 99,
  });

  final bool requestHeader;

  final bool requestBody;

  final bool responseBody;

  final bool responseHeader;

  final bool error;

  final int maxWidth;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _printRequestHeader(options);
    if (options.headers.isNotEmpty) {
      _prettyPrintData(
        data: options.queryParameters,
        header: 'Query Parameters',
        isError: false,
      );
    }

    if (requestBody && options.method != 'GET') {
      final Object? data = options.data;
      if (data == null) {
        super.onRequest(options, handler);
        return;
      } else if (data is FormData) {
        final formDataMap = <String, Object>{}
          ..addEntries(data.fields)
          ..addEntries(data.files);
        _prettyPrintData(
          data: formDataMap,
          header: 'Form data | ${data.boundary}',
          isError: false,
        );
      } else {
        _prettyPrintData(data: data, header: 'Request Body', isError: false);
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printResponseHeader(response);
    if (responseHeader) {
      _prettyPrintData(
        data: response.headers,
        header: 'Response Header',
        isError: false,
      );
    }

    if (responseBody) {
      _printResponse(response: response, isError: false);
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      if (err.type == DioExceptionType.badResponse) {
        final uri = err.response?.requestOptions.uri;
        _printHeader(
          header:
              'DioError '
              '║ Status: ${err.response?.statusCode} '
              '${err.response?.statusMessage}',
          text: uri.toString(),
          isError: true,
        );
        if (err.response != null && err.response?.data != null) {
          _printResponse(response: err.response, isError: true);
        }
      } else {
        _printHeader(
          header: 'DioError ║ ${err.type}',
          text: err.message ?? 'Message is null',
          isError: true,
        );
      }
    }
    return super.onError(err, handler);
  }

  void _printRequestHeader(RequestOptions options) {
    final uri = options.uri;
    final method = options.method;
    _printHeader(
      header: 'Request ║ $method',
      text: uri.toString(),
      isError: false,
    );
  }

  void _printResponseHeader(Response<dynamic> response) {
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;

    _printHeader(
      header:
          'Response '
          '║ $method '
          '║ Status: ${response.statusCode} ${response.statusMessage}',
      text: uri.toString(),
      isError: false,
    );
  }

  void _printHeader({
    required String header,
    required String text,
    required bool isError,
  }) {
    _printLine(text: '╔║ $header ║', isError: isError);
    _print(text: '║  $text', isError: isError);
    _printLine(text: '╚', isError: isError);
  }

  void _prettyPrintData({
    required data,
    required String header,
    required bool isError,
  }) {
    if (data is Map && data.isEmpty) {
      return;
    } else {
      _printLine(text: '╔ $header ', isError: isError);
      _stringifyData(data)
          .trim()
          .split('\n')
          .forEach((element) => _print(text: '║  $element', isError: isError));
      _printLine(text: '╚', isError: isError);
    }
  }

  void _printLine({required String text, required bool isError}) {
    _print(
      text:
          '$text'
          '${'═' * (maxWidth - text.length)}',
      isError: isError,
    );
  }

  void _printResponse({
    required Response<dynamic>? response,
    required bool isError,
  }) {
    final Object? data = response?.data;

    if (data != null) {
      _prettyPrintData(data: data, header: 'Response Body', isError: isError);
    }
  }

  void _print({required String text, required bool isError}) {
    if (isError) {
      LoggerHelper.error(text);
    } else {
      LoggerHelper.info(text);
    }
  }

  String _stringifyData(data) {
    final finalData = data is Function ? data() : data;
    if (finalData is Map || finalData is Iterable) {
      final encoder = JsonEncoder.withIndent(
        '  ',
        (object) => object.toString(),
      );
      return encoder.convert(finalData);
    } else {
      return finalData.toString();
    }
  }
}
