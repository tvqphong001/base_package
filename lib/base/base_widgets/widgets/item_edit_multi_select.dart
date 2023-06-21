import '../../../../../base/base.dart';
import 'bottom_sheets/bottom_sheet_multiselect.dart';
import 'bottom_sheets/bottom_sheet_single_select.dart';

class ItemEditMultiSelect<T> extends StatelessWidget {
  final String title;
  final List<T> listData;
  final List<T> listDataSelect;
  final bool Function(T itemSelect, T item) conditionSelect;
  final String Function(T data) displayText;
  final bool emptyResult;
  final bool isRequired;
  final Function(List<T>) onResult;
  const ItemEditMultiSelect({
    Key? key,
    required this.listData,
    required this.listDataSelect,
    required this.title,
    required this.conditionSelect,
    required this.displayText,
    required this.onResult,
    this.emptyResult = false,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            TextApp(
              title,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.grey,
            ),
            if (isRequired)
              const TextApp(
                '*',
                fontSize: 12,
                color: Colors.red,
              ),
          ],
        ),
        Button(
          onPressed: () async {
            var result = await showMultiSelectBottomSheet<T>(
              context:context,
              listData:listData,
              listCurrent: listDataSelect,
              conditionSelect: conditionSelect,
              displayText: displayText,
              title: title,
            );
            var condition = emptyResult ? true : result?.isNotEmpty ?? false;
            if (result != null && condition) {
              onResult(result);
            }
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextApp(
                    listDataSelect.isEmpty
                        ? title
                        : listDataSelect
                            .map((element) => displayText(element))
                            .toList()
                            .join(', '),
                    fontWeight: FontWeight.w400,
                    maxLines: 3,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemEditSingleSelect<T> extends StatelessWidget {
  final String title;
  final T? currentData;
  final List<T> listData;
  final String Function(T? data) displayText;
  final bool isRequired;
  final Function(T) onResult;
  const ItemEditSingleSelect({
    Key? key,
    required this.listData,
    required this.title,
    required this.displayText,
    required this.onResult,
    this.isRequired = false,
    required this.currentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            TextApp(
              title,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.grey,
            ),
            if (isRequired)
              const TextApp(
                '*',
                fontSize: 12,
                color: Colors.red,
              ),
          ],
        ),
        Button(
          onPressed: () async {
            var result = await showBottomSheetSingleSelect<T>(
                title: title,
                context: context,
                displayText: displayText,
                currentData: currentData,
                listData: listData);

            if (result != null) {
              onResult(result);
            }
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextApp(
                    displayText(currentData).isEmpty
                        ? title
                        : displayText(currentData),
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
