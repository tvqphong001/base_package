import 'package:base_package/base/base_http_service/base_response.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

mixin StateMixinExtensionsObject<T> on StateMixin<T> {
  final refreshController = RefreshController();

  Future handleDataStatus({
    required Future<ApiResponse<T>> future,
    Function? handleError,
    bool showLoading = true,
  }) async {
    if(showLoading){
      change(null, status: RxStatus.loading());
    }

    var resp = await future;

    if (resp.isSuccess) {
      var status = RxStatus.success();
      var data = resp.data;

      change(data, status: status);
    } else {
      if(handleError != null){
        handleError.call();
      }else{
        change(state, status: RxStatus.error(resp.apiError?.detail));
      }
    }
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

      if(list.isEmpty){
        status = RxStatus.empty();
      }

      change(list, status: status);
    } else {
      if(handleError != null){
        handleError!();
      }else{
        change(state, status: RxStatus.error(resp.apiError?.detail));
      }
    }

    refreshController.refreshCompleted();
  }
}

mixin StateMixinPageExtensions<T> on StateMixin<Paginate<T>> {

  Paginate<T> get statesRequired => state??Paginate(list: []);

  final refreshController = RefreshController();

  Future handleDataPaginateStatus({
    required Future<ApiResponse<Paginate<T>>> Function(int page) future,
    required bool refresh,
    bool showLoading = true,
  }) async {
    var currentPage = (state?.currentPage??1)+1;

    if(refresh){
      if(showLoading){
        change(null,status: RxStatus.loading());
      }
      currentPage = 1;
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

      change(paginate,status: status);

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