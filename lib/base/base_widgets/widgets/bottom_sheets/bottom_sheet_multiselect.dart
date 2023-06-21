import 'package:base_package/base/base.dart';

class BottomSheetData<T> {
  final String text;
  final T data;
  final bool selected;

  BottomSheetData<T> copyWith({
    String? text,
    T? data,
    bool? selected,
  }) {
    return BottomSheetData<T>(
        text: text ?? this.text,
        data: data ?? this.data,
        selected: selected ?? this.selected);
  }

  const BottomSheetData({
    required this.text,
    required this.data,
    this.selected = false,
  });
}

Future<List<T>?> showMultiSelectBottomSheet<T>({
  required BuildContext context,
  required List<T> listData,
  required List<T> listCurrent,
  required bool Function(T itemSelect, T item) conditionSelect,
  required String Function(T data) displayText,
  String? title,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: true,
    builder: (context) {
      return BottomSheetMultiSelect<T>(
        list: listData,
        listCurrent: listCurrent,
        title: title,
        displayText: displayText,
        conditionSelect: conditionSelect,
      );
    },
  );
}

class BottomSheetMultiSelect<T> extends StatefulWidget {
  final List<T> list;
  final List<T> listCurrent;
  final bool Function(T itemSelect, T item) conditionSelect;
  final String Function(T data) displayText;
  final String? title;
  const BottomSheetMultiSelect(
      {Key? key,
      required this.list,
      this.title,
      required this.listCurrent,
      required this.conditionSelect,
      required this.displayText})
      : super(key: key);

  @override
  State<BottomSheetMultiSelect<T>> createState() =>
      _BottomSheetMultiSelectState<T>();
}

class _BottomSheetMultiSelectState<T> extends State<BottomSheetMultiSelect<T>> {
  late List<BottomSheetData<T>> list;

  @override
  void initState() {
    super.initState();
    // list = widget.list;

    list = widget.list.map((element) {
      var selected = false;
      for (var i in widget.listCurrent) {
        if (widget.conditionSelect(i, element)) {
          selected = true;
          break;
        }
      }
      return BottomSheetData(
          data: element, text: widget.displayText(element), selected: selected);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.title != null) ...[
            const SizedBox(
              height: 25,
            ),
            TextApp(widget.title!, fontWeight: FontWeight.bold, fontSize: 18),
            const SizedBox(
              height: 20,
            ),
          ],
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = list[index];
                  return CheckboxListTile(
                    value: item.selected,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          list[index] = item.copyWith(selected: value);
                        });
                      }
                    },
                    title: Text(item.text),
                  );
                },
                itemCount: list.length),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Button(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const TextApp('cancel'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Button(
                  onPressed: () {
                    var listData = list.where((element) => element.selected);
                    // if(listData.toList().isNotEmpty){
                    var result = listData.map((e) => e.data).toList();
                    Navigator.pop(context, result);
                    // }
                  },
                  child: const TextApp('confirm'),
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
