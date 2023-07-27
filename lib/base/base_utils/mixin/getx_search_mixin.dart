import 'package:base_package/base/base_constants.dart';
import 'package:get/get.dart';

mixin SearchMixin on GetxController{
  var searchText = ''.obs;

  void onSearch(searchText);
  Worker? workerSearch;

  @override
  void onInit() {
    workerSearch = debounce<String>(searchText, (callback) {
      onSearch(callback);
    },time: dDebounceDuration);
    super.onInit();
  }

  @override
  void onClose() {
    workerSearch?.dispose();
    super.onClose();
  }
}