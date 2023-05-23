import 'package:base_package/base/base.dart';

class CheckBoxList<T> extends StatefulWidget {
  final List<CheckBoxListData<T>> listData;
  final Function(List<T>) onChange;
  const CheckBoxList({Key? key, required this.listData, required this.onChange})
      : super(key: key);

  @override
  State<CheckBoxList<T>> createState() => _CheckBoxListState<T>();
}

class _CheckBoxListState<T> extends State<CheckBoxList<T>> {
  final allCheck = CheckBoxListData(text: 'All checked');
  late List<CheckBoxListData<T>> checkBoxList;

  @override
  void initState() {
    checkBoxList = widget.listData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: allCheck.value,
          onChanged: (value) => checkAll(allCheck),
          contentPadding: EdgeInsets.zero,
          title: TextApp(allCheck.text, fontWeight: FontWeight.bold),
        ),
        ...checkBoxList
            .map(
              (e) => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: e.value,
                onChanged: (value) => checkItems(e, checkBoxList.indexOf(e)),
                contentPadding: EdgeInsets.zero,
                title: TextApp(e.text),
              ),
            )
            .toList()
      ],
    );
  }

  checkAll(CheckBoxListData value) {
    setState(() {
      value.value = !value.value;
      for (var element in checkBoxList) {
        element.value = value.value;
      }
    });
  }

  checkItems(CheckBoxListData value, int index) {
    setState(() {
      checkBoxList[index].value = !value.value;
    });

    var checkAll = checkBoxList.every((element) => element.value);
    if (checkAll) {
      allCheck.value = true;
    } else {
      allCheck.value = false;
    }
  }
}

class CheckBoxListData<T> {
  String text;
  bool value;
  T? data;
  CheckBoxListData({this.value = false, required this.text, this.data});
}
