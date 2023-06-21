import 'package:base_package/base/base_http_service/base_response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';

mixin StateMixinExtensions<T> on StateMixin<List<T>> {
  Future handleDataListStatus({
    required Future<ApiResponse<List<T>>> future,
  }) async {
    change(null, status: RxStatus.loading());

    var resp = await future;

    if (resp.isSuccess) {
      change(resp.data ?? [], status: RxStatus.success());
    } else {
      change(state, status: RxStatus.error(resp.apiError?.detail));
    }
  }
}

mixin StateMixinPageExtensions<T> on StateMixin<Paginate<T>> {
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
  }
}