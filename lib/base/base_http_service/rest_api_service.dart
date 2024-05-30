import '../base.dart';

abstract class RestApiServiceImp {
  Future<ApiResponse<Response?>> post({required String path,  body, Options? options});
  Future<ApiResponse<Response?>> put({required String path,  body, Options? options});

  Future<ApiResponse<Response?>> get({required String path, Map<String, dynamic>? query, Options? options});
  Future<ApiResponse<Response?>> delete({required String path, Map<String, dynamic>? data, Options? options});
}

class RestApiService implements RestApiServiceImp {
  final Dio dio;

  const RestApiService({required this.dio});

  void init(
    String baseUrl, {
    int connectTimeout = 60000,
    Map<String, dynamic>? headers,
  }) async {
    dio.options = BaseOptions(baseUrl: baseUrl, connectTimeout: Duration(milliseconds: connectTimeout), headers: headers);
  }

  saveToken(String accessToken) {
    dio.options.headers[authorization] = "$bearer";
    dio.options.headers[authorization] = "$bearer $accessToken";
    print('object');
  }

  deleteToken() {
    dio.options.headers[authorization] = "$bearer ";
  }

  @override
  Future<ApiResponse<Response?>> post(
      {required String path,  body, Options? options}) async {
    if (body != null) {
      if(body is Map<String, dynamic>){
        removeNull(body);
      }

    }

    return await handleResponseFunc(future: () {
      return dio.post(path, data: body, options: options);
    },);
  }

  @override
  Future<ApiResponse<Response?>> get(
      {required String path, Map<String, dynamic>? query, Options? options}) async {
    if (query != null) {
      if(query is Map<String, dynamic>){
        removeNull(query);
      }

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

  @override
  Future<ApiResponse<Response?>> delete({required String path, Map<String, dynamic>? data, Options? options}) async{
    return await handleResponseFunc(future: () {
      return dio.delete(path, data: data, options: options);
    },);
  }

  @override
  Future<ApiResponse<Response?>> put({required String path, body, Options? options}) async{
    if (body != null) {
      if(body is Map<String, dynamic>){
        removeNull(body);
      }

    }

    return await handleResponseFunc(future: () {
      return dio.put(path, data: body, options: options);
    },);
  }
}
