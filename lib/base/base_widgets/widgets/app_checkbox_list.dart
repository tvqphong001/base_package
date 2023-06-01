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
  late CheckBoxListData allCheck = CheckBoxListData(text: 'All checked',data: widget.listData[0]);
  late List<CheckBoxListData<T>> checkBoxList = widget.listData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: allCheck.value,
          onChanged: (value) => checkAll(allCheck),
          contentPadding:EdgeInsets.zero,
          title: TextApp(allCheck.text,fontWeight: FontWeight.bold),
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

    var results = checkBoxList.where((element) => element.value).toList();
    var list = results.map((e) => e.data).toList();
    widget.onChange(list);
  }

  checkItems(CheckBoxListData value, int index){
    setState(() {
      checkBoxList[index].value = !value.value;
    });

    var checkAll = checkBoxList.every((element) => element.value);
    if(checkAll){
      allCheck.value = true;
    }else{
      allCheck.value = false;
    }

    var results = checkBoxList.where((element) => element.value).toList();
    var list = results.map((e) => e.data).toList();
    widget.onChange(list);
  }
}

class CheckBoxListData<T> {
  String text;
  bool value;
  T data;
  CheckBoxListData({this.value = false, required this.text, required this.data});
}

