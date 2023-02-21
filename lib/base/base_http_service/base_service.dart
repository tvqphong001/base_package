import 'package:dio/dio.dart';
import 'base_response.dart';

export 'base_response.dart';
export 'base_http_service.dart';
export 'rest_api_service.dart';

abstract class BaseHttpService {
  const BaseHttpService();
  Future<ApiResponse<Response?>> post({required String path});

  Future<ApiResponse<Response?>> get({required String path});
}
