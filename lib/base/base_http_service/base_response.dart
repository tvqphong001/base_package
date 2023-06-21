import 'dart:developer';

import '../../../base/base.dart';

class ApiResponse<DATA> {
  final DATA? data;
  final ApiError? apiError;
  final PageData? meta;
  final int? statusCode;

  DATA get requiredData => data!;

  bool get isSuccess => statusCode == httpStatusCodeSuccess200 || statusCode == httpStatusCodeSuccess201;

  ApiResponse({
    this.data,
    this.apiError,
    this.statusCode,
    this.meta,
  });
}

class ApiError {
  final Object? error;
  final int? code;
  final String? title;
  final String? detail;

  const ApiError({this.code, this.title, this.detail,this.error});

  bool get permissionError => code == 3015;

  bool get internetError => code == -101;

  factory ApiError.internetError(){
    return const ApiError(code: -101,title: 'internet connection',detail: 'please check internet');
  }

  factory ApiError.fromJson(Map<dynamic, dynamic> json) {
    int mCode = -1;
    try {
      if (json['code'] is String) {
        var jCode = json['code']??'';
        mCode = int.parse((jCode as String).replaceAll('E_', ''));
      } else if (json['code'] is int) {
        mCode = json['code'];
      }
    } catch (e) {
      print('ApiError.fromJson $e');
    }
    return ApiError(code: mCode, title: json['title'], detail: json['detail']);
  }
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

class Paginate<T> extends Equatable{
  final List<T> list;
  final int currentPage;
  final int? totalPages;
  final int? totalRecords;
  const Paginate({required this.list, this.currentPage = 1,this.totalPages,this.totalRecords});

  Paginate<T> copyWith({List<T>? data,
    int? currentPage,
    int? totalPages,
    int? totalRecords,}){
    return Paginate(
      list: data??this.list,
      totalRecords: totalRecords??this.totalRecords,
      totalPages: totalPages??this.totalPages,
      currentPage: currentPage??this.currentPage,
    );
  }

  Paginate<T> update({Paginate<T>? data}){
    if(data == null) return this;
    return Paginate(
      list: [...this.list,...data.list],
      totalRecords: this.totalRecords,
      totalPages: this.totalPages,
      currentPage: data.currentPage,
    );
  }

  Paginate<T> updateList({List<T>? list}){

    return Paginate(
      list: [...list??[]],
      totalRecords: this.totalRecords,
      totalPages: this.totalPages,
      currentPage: this.currentPage,
    );
  }

  @override
  List<Object?> get props => [list];
}

typedef ApiResponseType<T> = T Function(Response);
typedef ApiResponseFunc<T> = ApiResponse<T> Function(Response);

Future<ApiResponse<T>> handleAPIResponse<T>(
    {Response? response,
      Future Function()? future,
      String? keyRespData,
      T? defaultRespData,
      ApiResponseType<T>? handleSuccess,
      ApiResponseFunc<T>? handleSuccessFunc,
      ApiResponseFunc<T>? handleFailureFunc}) async {
  try {
    if (future != null) {
      response = await future();
    }
    if (response == null) {
      return ApiResponse(
          statusCode: -1,
          apiError: const ApiError(
              code: -1, detail: 'response null when handleAPIResponse'));
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // handle call api success
      if (handleSuccess != null) {
        return ApiResponse(
          data: handleSuccess(response),
          statusCode: response.statusCode,
        );
      } else if (handleSuccessFunc != null) {
        return handleSuccessFunc.call(response);
      } else if (keyRespData != null) {
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
        return ApiResponse(
            statusCode: response.statusCode,
            apiError: ApiError(
              detail: response.statusMessage,
              code: response.statusCode,
            ));
      }
    }
  } catch (e,stack) {
    log(e.toString(),stackTrace: stack);
    if (e is DioError) {
      var mResp = e.response;
      return ApiResponse(
          statusCode: mResp?.statusCode,
          apiError: ApiError(
              code: mResp?.statusCode,
              detail: e.toString(),
              error: e,
              title: mResp?.statusMessage,));
    }
    return ApiResponse(
        statusCode: response?.statusCode,
        apiError: ApiError(
            code: response?.statusCode,
            detail: e.toString(),
            error: e,
            title: response?.statusMessage));
  }
}
