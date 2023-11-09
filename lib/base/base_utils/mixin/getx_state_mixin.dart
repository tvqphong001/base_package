import 'package:base_package/base/base_http_service/base_response.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

mixin StateMixinExtensions<T> on StateMixin<List<T>> {
  Future handleDataListStatus({
    required Future<ApiResponse<List<T>>> future,
    List<T> Function(List<T>)? customList,
    Function? handleError,
  }) async {
    change(null, status: RxStatus.loading());

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
  }
}

mixin StateMixinPageExtensions<T> on StateMixin<Paginate<T>> {
  final refreshController = RefreshController();

  Future handleDataPaginateStatus({
    required Future<ApiResponse<Paginate<T>>> Function(int page) future,
    required bool refresh,
  }) async {
    var currentPage = (state?.currentPage??1)+1;

    if(refresh){
      change(null,status: RxStatus.loading());
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