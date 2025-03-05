import 'package:base_package/base/base_http_service/base_response.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';


mixin StateMixinExtensionsObject<T> on StateMixin<T> {
  final refreshController = RefreshController();

  Future handleDataStatus({
    required Future<ApiResponse<T>> future,
    Function? handleError,
    Function(T? data)? handleSuccess,
    bool showLoading = true,
  }) async {
    if(showLoading){
      change(state, status: RxStatus.loading());
    }

    var resp = await future;

    if (resp.isSuccess) {
      var status = RxStatus.success();
      var data = resp.data;

      if(handleSuccess != null){
        handleSuccess.call(data);
      }else{
        change(data, status: status);
      }

    } else {
      if(handleError != null){
        handleError.call();
      }else{
        change(state, status: RxStatus.error(resp.apiError?.detail));
      }
    }
    refreshController.loadComplete();
    refreshController.refreshCompleted();
  }
}

mixin StateMixinExtensions<T> on StateMixin<List<T>> {
  List<T> get statesRequired => state??[];

  final refreshController = RefreshController();

  Future handleDataListStatus({
    required Future<ApiResponse<List<T>>> future,
    List<T> Function(List<T>)? customList,
    Function? handleError,
    bool showLoading = true,
    bool needEmpty = true,
  }) async {
    if(showLoading){
      change(null, status: RxStatus.loading());
    }

    var resp = await future;

    if (resp.isSuccess) {
      var status = RxStatus.success();
      var list = resp.data ?? [];
      if(customList != null){
        list.assignAll(customList(list));
      }

      if(list.isEmpty && needEmpty){
        status = RxStatus.empty();
      }

      change(list, status: status);
    } else {
      if(handleError != null){
        handleError();
      }else{
        change(state, status: RxStatus.error(resp.apiError?.detail));
      }
    }

    refreshController.refreshCompleted();
  }
}

var currentPageDefault = 1;

mixin StateMixinPageExtensions<T> on StateMixin<Paginate<T>> {

  Paginate<T> get statesRequired => state??const Paginate(list: []);

  final refreshController = RefreshController();

  Future handleDataPaginateStatus({
    required Future<ApiResponse<Paginate<T>>> Function(int page) future,
    required bool refresh,
    bool showLoading = true,
  }) async {
    var currentPage = (state?.currentPage??currentPageDefault)+1;

    if(refresh){
      if(showLoading){
        change(null,status: RxStatus.loading());
      }
      currentPage = currentPageDefault;
    }

    var resp = await future(currentPage);

    if(resp.isSuccess){
      var status = RxStatus.success();
      var paginate = state;

      if(refresh){
        paginate = resp.data;
      }else{
        paginate = state?.update(data: resp.data);
      }

      if(paginate?.list.isEmpty??false){
        status = RxStatus.empty();
      }

      if(resp.data!.list.isNotEmpty || refresh){
        change(paginate,status: status);
      }else{
        // not handle
        
      }
    }else{
      change(state,status: RxStatus.error(resp.apiError?.title));
    }

    if(refresh){
      refreshController.refreshCompleted();
    }else{
      refreshController.loadComplete();
    }
  }
}