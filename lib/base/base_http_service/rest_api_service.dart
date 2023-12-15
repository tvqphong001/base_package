import '../base.dart';

abstract class RestApiServiceImp {
  Future<ApiResponse<Response?>> post({required String path, Map<String, dynamic>? body, Options? options});

  Future<ApiResponse<Response?>> get({required String path, Map<String, dynamic>? query, Options? options});
}

class RestApiService implements RestApiServiceImp {
  final Dio dio;

  const RestApiService({required this.dio});

  void init(
    String baseUrl, {
    int connectTimeout = 60000,
    Map<String, dynamic>? headers,
  }) async {
    dio.options = BaseOptions(baseUrl: baseUrl, connectTimeout: connectTimeout, headers: headers);
  }

  saveToken(String accessToken) {
    dio.options.headers[authorization] = "$bearer $accessToken";
  }

  deleteToken() {
    dio.options.headers[authorization] = "$bearer ";
  }

  Future<ApiResponse<Response?>> post(
      {required String path, Map<String, dynamic>? body, Options? options}) async {
    if (body != null) {
      removeNull(body);
    }

    return await handleResponseFunc(future: () {
      return dio.post(path, data: body, options: options);
    },);
  }

  Future<ApiResponse<Response?>> get(
      {required String path, Map<String, dynamic>? query, Options? options}) async {
    if (query != null) {
      removeNull(query);
    }

    return await handleResponseFunc(future: () {
      return dio.get(path, queryParameters: query, options: options);
    },);
  }

  Future<ApiResponse<Response?>> handleResponseFunc({required Future<Response?> Function() future})async{
    try {
      final resp = await future();
      return ApiResponse(data: resp,statusCode: resp?.statusCode);
    } on DioError catch (e, stack) {
      print(e);
      var resp = e.response;
      return ApiResponse(data: resp,statusCode: resp?.statusCode,apiError: ApiError(
        error: e,
      ));
    } catch (e, stack) {
      print(e);
      return ApiResponse(apiError: ApiError(
        error: e,
      ));
    }
  }
}
