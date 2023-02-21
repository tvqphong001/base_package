import '../base.dart';

class RestApiService extends BaseHttpService {
  static final Dio dio = Dio();

  const RestApiService(dio);

  static Future<RestApiService> init(String baseUrl) async {
    dio.options = BaseOptions(baseUrl: baseUrl);
    var restApiService = RestApiService(dio);
    return restApiService;
  }

  static saveToken(String accessToken) {
    dio.options.headers[authorization] = "$bearer $accessToken";
  }

  static deleteToken() {
    dio.options.headers[authorization] = "$bearer ";
  }

  @override
  Future<ApiResponse<Response?>> post({required String path, Map<String, dynamic>? body}) async {
    try {
      if (body != null) {
        removeNull(body);
      }

      final resp = await dio.post(path, data: body);

      return ApiResponse(data: resp);
    } catch (e) {
      print(e);
      return ApiResponse(
        statusCode: -1,
        apiError: ApiError(
          code: -1,
          title: 'post error',
          detail: e.toString(),
          error: e,
        ),
      );
    }
  }

  @override
  Future<ApiResponse<Response?>> get({required String path, Map<String, dynamic>? query}) async {
    try {
      if (query != null) {
        removeNull(query);
      }
      final resp = await dio.get(path, queryParameters: query);

      return ApiResponse(data: resp);
    } catch (e) {
      return ApiResponse(
        statusCode: -1,
        apiError: ApiError(
          code: -1,
          title: 'get error',
          detail: e.toString(),
          error: e,
        ),
      );
    }
  }
}
