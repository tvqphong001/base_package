import '../../../base/base.dart';

class ApiResponse<DATA> {
  final DATA? data;
  final ApiError? apiError;
  final PageData? meta;
  final int? statusCode;

  bool get isSuccess => statusCode == httpStatusCodeSuccess200 || statusCode == httpStatusCodeSuccess201;

  ApiResponse({this.data, this.apiError, this.statusCode, this.meta});
}

class ApiError {
  final Object? error;
  final int? code;
  final String? title;
  final String? detail;

  ApiError({this.error, this.code, this.title, this.detail});

  ApiError.fromJson(Map<dynamic, dynamic> json)
      : code = json['code'],
        title = json['title'],
        detail = json['detail'],
        error = null;
}

class PageData {
  int? totalPages;
  int? totalRecords;

  PageData({this.totalPages, this.totalRecords});

  PageData.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPages'] = totalPages;
    data['totalRecords'] = totalRecords;
    return data;
  }
}

typedef ApiResponseType<T> = ApiResponse<T> Function(Response);

Future<ApiResponse<T>> handleAPIResponse<T>(
    {required Response? response,
    String? keyRespData,
    T? defaultRespData,
    ApiResponseType<T>? handleSuccessFunc,
    ApiResponseType<T>? handleFailureFunc}) async {
  try {
    if (response != null) {
      if (response.statusCode == httpStatusCodeSuccess200 || response.statusCode == httpStatusCodeSuccess201) {
        // handle call api success
        if (handleSuccessFunc != null) {
          return handleSuccessFunc.call(response);
        }

        if (keyRespData != null) {
          return ApiResponse(
            statusCode: response.statusCode,
            data: response.data[keyRespData] ?? defaultRespData as T,
          );
        } else {
          return ApiResponse(statusCode: response.statusCode);
        }
      } else {
        // handle call api fail
        if (handleFailureFunc != null) {
          return handleFailureFunc.call(response);
        } else {
          return ApiResponse(statusCode: response.statusCode);
        }
      }
    } else {
      return ApiResponse(
        statusCode: -1,
        apiError: ApiError(
          code: -1,
          title: 'error',
          detail: 'error',
          error: null,
        ),
      );
    }
  } catch (e) {
    return ApiResponse(
      statusCode: response?.statusCode ?? -1,
      apiError: ApiError(
        code: response?.statusCode ?? -1,
        title: 'handleAPIResponse error',
        detail: 'error',
      ),
    );
  }
}
