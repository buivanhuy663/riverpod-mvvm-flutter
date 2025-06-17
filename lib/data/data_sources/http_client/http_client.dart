import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/auth/login_request_model.dart';
import '../../models/auth/login_response_model.dart';

class HttpClient {
  HttpClient(this.baseUrl);

  final String baseUrl;

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    final String url = '$baseUrl/cskh/user/login';
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Accept-Encoding': 'gzip, deflate, br, zstd',
      'Accept-Language': 'vi',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json;charset=UTF-8',
      'Host': 'cskh-api.cpc.vn',
      'Origin': 'https://cskh.cpc.vn',
      'Referer': 'https://cskh.cpc.vn/',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-site',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36',
      'sec-ch-ua': "'Not(A:Brand';v='99', 'Google Chrome';v='133', 'Chromium';v='133'",
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': "'Windows'",
    };

    final Map<String, dynamic> body = {
      'username': loginRequestModel.email,
      'password': loginRequestModel.password,
      'grant_type': 'password',
      'scope': 'CSKH',
      'ThongTinCaptcha': {'captcha': 'undefined', 'token': 'undefined'},
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    dynamic jsonData;
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
    } else {
      throw Exception('Status code: ${response.statusCode}, Message: ${response.body}');
    }

    final accessToken = jsonData['access_token'];
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception(
        'Login failed: Access token is null or empty. Response: ${response.body}',
      );
    } else {
      return LoginResponseModel(
        accessToken: jsonData['access_token'],
      );
    }
  }
}
