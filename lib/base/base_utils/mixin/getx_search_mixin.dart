import 'package:base_package/base/base_constants.dart';
import 'package:get/get.dart';

mixin SearchMixin on GetxController{
  var searchText = ''.obs;
  var _oldSearch = '';

  void onSearch(String searchText);
  Worker? workerSearch;

  @override
  void onInit() {
    workerSearch = debounce<String>(searchText, (callback) {
      if(callback.trim().toLowerCase() != _oldSearch.trim().toLowerCase()){
        onSearch(callback.trim());
        _oldSearch = callback;
      }
    },time: Duration(milliseconds: 1000));
    super.onInit();
  }

  @override
  void onClose() {
    workerSearch?.dispose();
    super.onClose();
  }
}