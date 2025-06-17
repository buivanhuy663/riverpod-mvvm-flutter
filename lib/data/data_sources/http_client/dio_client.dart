import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../models/auth/login_request_model.dart';
import '../../models/auth/login_response_model.dart';
import 'api_constants.dart';

part 'dio_client.g.dart';

@RestApi()
abstract class DioClient {
  factory DioClient(Dio dio, {String baseUrl}) = _DioClient;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequestModel);

  @GET(ApiConstants.data)
  Future<dynamic> getData();
}
