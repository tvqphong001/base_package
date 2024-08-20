import 'dart:async';

import 'package:base_package/base/base.dart';

Future<T?> showDialogSelectCustomDataSearch<T>({
  required List<T> initData,
  required String Function(T value) displayName,
  T? value,
  bool Function(T value, String searchText)? searchFunc,
  double? widthDialog,
  String? searchHint,
}) {
  if(initData.isEmpty){
    throw 'initData is empty';
  }
  return Get.dialog<T>(_SelectCustomDataWidget<T>(
    initData: initData,
    displayName: displayName,
    searchFunc: searchFunc,
    widthDialog: widthDialog,
    searchHint: searchHint,
    value: value,
  ));
}

class _SelectCustomDataWidget<T> extends GetView<_SelectCustomDataController> {
  final List<T> initData;
  final String Function(T value) displayName;
  final T? value;
  final bool Function(T value, String searchText)? searchFunc;
  final double? widthDialog;
  final String? searchHint;

  const _SelectCustomDataWidget({
    super.key,
    required this.displayName,
    required this.initData,
    this.value,
    this.searchFunc,
    this.widthDialog,
    this.searchHint,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(_SelectCustomDataController());
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      // contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      contentPadding: EdgeInsets.only(top: 16,bottom: 24),
      content: SizedBox(
        width: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFieldSearchBase(
                hintText: searchHint??'Search text',
                showPrefixIconSearch: false,
                suffixIcon: Icon(
                  Icons.search,
                  size: 25,
                  color: theme.primaryColor,
                ),
                onChanged: (value) {
                  controller.searchText.value = value;
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ObxBuilder(builder: () {
                final textSearch = controller.searchText.value;
                List<T> list = []..assignAll(initData);

                if (searchFunc != null) {
                  list = list.where((element) => searchFunc!(element, textSearch)).toList();
                }else{
                  list = list.where((element) => element.toString() == textSearch).toList();
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {

                    final customer = list[index];
                    final isSelect = value == customer;
                    return Button(

                      onPressed: () {
                        Get.back(result: customer);
                      },
                      background: isSelect ? Color.fromARGB(255, 240, 243, 248) : null,
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextApp(
                              displayName(customer),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectCustomDataController<T> extends GetxController with SearchMixin {
  @override
  void onSearch(String searchText) {
  }
}

class TextFieldSearchBase extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final bool showPrefixIconSearch;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? hintText;
  const TextFieldSearchBase({
    super.key,
    this.onChanged,
    this.showPrefixIconSearch = true,
    this.suffixIcon, this.controller, this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            prefixIcon: showPrefixIconSearch
                ? Icon(Icons.search, color: theme.primaryColor, size: 25)
                : null,
            isDense: true,
            suffixIcon: suffixIcon,
            hintText: hintText),
      ),
    );
  }
}
