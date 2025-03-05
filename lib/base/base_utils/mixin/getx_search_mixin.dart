import 'package:base_package/base/base.dart';

mixin SearchMixin on GetxController {
  var searchText = ''.obs;
  var _oldSearch = '';
  final textEditingController = TextEditingController();

  void onSearch(String searchText);
  Worker? workerSearch;

  clearSearch() {
    searchText.value = '';
    textEditingController.clear();
  }

  @override
  void onInit() {
    workerSearch = debounce<String>(searchText, (callback) {
      if (callback.trim().toLowerCase() != _oldSearch.trim().toLowerCase()) {
        onSearch(callback.trim());
        _oldSearch = callback;
      }
    }, time: Duration(milliseconds: 1000));
    super.onInit();
  }

  @override
  void onClose() {
    workerSearch?.dispose();
    textEditingController.dispose();
    super.onClose();
  }
}

mixin SearchBarMixin on SearchMixin {
  final showSearch = false.obs;
  final focusNodeSearch = FocusNode();

  @override
  void onClose() {
    focusNodeSearch.dispose();
    super.onClose();
  }

  void showHideSearch() {
    showSearch.value = !showSearch.value;

    if (!showSearch.value) {
      focusNodeSearch.unfocus();
      clearSearch();
    } else {
      focusNodeSearch.requestFocus();
    }
  }

  Widget buttonSearch({Color? colorButton}) {
    return ObxBuilder(builder: () {
      return IconButton(
        icon: Icon(
          showSearch.value ? Icons.close : Icons.search,
          color: colorButton??Colors.white,
        ),
        onPressed: () {
          showHideSearch();
        },
      );
    });
  }

  SearchHeaderObj searchObject({Color? colorButton}) => SearchHeaderObj(
        showSearch: showSearch,
        onChanged: (value) {
          searchText.value = value;
        },
        focusNode: focusNodeSearch,
        controller: textEditingController, buttonSearch: buttonSearch(colorButton: colorButton),
      );
}

class SearchHeaderObj {
  final Rx<bool> showSearch;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Widget buttonSearch;

  const SearchHeaderObj(
      {required this.showSearch,
      required this.onChanged,
      required this.focusNode,
      required this.controller,
      required this.buttonSearch,

      });
}
