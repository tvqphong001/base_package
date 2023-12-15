import 'package:dio/dio.dart';
import 'base_response.dart';

export 'base_response.dart';
export 'base_http_service.dart';
export 'rest_api_service.dart';

abstract class BaseHttpService {
  const BaseHttpService();
  Future<Response?> post({required String path, Options? options});

  Future<Response?> get({required String path, Options? options});
}
