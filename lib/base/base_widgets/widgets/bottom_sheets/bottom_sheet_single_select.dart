

import 'package:base_package/base/base.dart';
import 'package:get/get.dart';

Future<T?> showBottomSheetSingleSelect<T>({
  required String title,
  required T? currentData,
  required List<T> listData,
  required String Function(T) displayText,
  required BuildContext context,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return _BottomSheetWidget<T>(
        data: currentData,
        listData: listData,
        displayText: displayText,
        title: title,
      );
    },
  );
}

class _BottomSheetWidget<T> extends StatefulWidget {
  final T? data;
  final List<T> listData;
  final String Function(T) displayText;
  final String title;
  const _BottomSheetWidget(
      {Key? key,
      required this.data,
      required this.listData,
      required this.displayText,
      required this.title})
      : super(key: key);

  @override
  State<_BottomSheetWidget<T>> createState() => _BottomSheetWidgetState<T>();
}

class _BottomSheetWidgetState<T> extends State<_BottomSheetWidget<T>> {
  late Rx<T> groupValue = (widget.data ?? widget.listData[0]).obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: TextApp(
              widget.title,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Obx(() {
                var radioValue = groupValue.value;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.listData.map((e) {
                    return RadioListTile<T>(
                        title: TextApp(
                          widget.displayText(e),
                        ),
                        value: e,
                        groupValue: radioValue,
                        onChanged: (value) {
                          if (value != null) {
                            groupValue.value = value;
                          }
                        });
                  }).toList(),
                );
              }),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Button(
                  onPressed: () {
                    Get.back();
                  },
                  child: const TextApp('close'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Button(
                  onPressed: () {
                    Navigator.of(context).pop(groupValue.value);
                  },
                 child: const TextApp('CONFIRM'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
