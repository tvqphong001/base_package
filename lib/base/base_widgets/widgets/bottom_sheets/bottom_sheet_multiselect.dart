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

Future<List<T>?> showMultiSelectBottomSheet<T>(
    BuildContext context, List<BottomSheetData<T>> list,
    {String? title}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: true,
    builder: (context) {
      return BottomSheetMultiSelect<T>(list: list, title: title);
    },
  );
}

class BottomSheetMultiSelect<T> extends StatefulWidget {
  final List<BottomSheetData<T>> list;
  final String? title;
  const BottomSheetMultiSelect({Key? key, required this.list, this.title})
      : super(key: key);

  @override
  State<BottomSheetMultiSelect<T>> createState() => _BottomSheetMultiSelectState<T>();
}

class _BottomSheetMultiSelectState<T> extends State<BottomSheetMultiSelect<T>> {
  late List<BottomSheetData<T>> list;

  @override
  void initState() {
    super.initState();
    list = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.title != null) ...[
            const SizedBox(
              height: 25,
            ),
            TextApp(
                 widget.title!, fontWeight: FontWeight.bold, fontSize: 18),
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
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const TextApp('Cancel'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      var listData = list.where((element) => element.selected);
                      if(listData.toList().isNotEmpty){
                        var result = listData.map((e) => e.data).toList();
                        Navigator.pop(context, result);
                      }
                    },
                    child: const TextApp('Confirm')),
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
