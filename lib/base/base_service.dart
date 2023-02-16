import 'package:dio/dio.dart';
import 'package:mpos/base/base_response.dart';

abstract class BaseHttpService {
  const BaseHttpService();
  Future<ApiResponse<Response?>> post({required String path});

  Future<ApiResponse<Response?>> get({required String path});
}
