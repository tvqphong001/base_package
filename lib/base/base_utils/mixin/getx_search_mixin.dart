import 'package:base_package/base/base.dart';

mixin SearchMixin on GetxController{
  var searchText = ''.obs;
  var _oldSearch = '';
  final textEditingController = TextEditingController();

  void onSearch(String searchText);
  Worker? workerSearch;

  clearSearch(){
    searchText.value = '';
    textEditingController.clear();
  }



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
    textEditingController.dispose();
    super.onClose();
  }
}