import 'package:dropdown_button2/dropdown_button2.dart';

import '../../base.dart';

class AppDropDownButton<T> extends StatelessWidget {
  final String? hint;
  final Widget? hintWidget;
  final T? value;
  final List<DropdownMenuItem> items;
  final Widget? customButton;
  final Function(T)? onChange;
  final List<double>? customItemsHeights;
  const AppDropDownButton(
      {Key? key,
      this.hint,
      this.value,
      required this.items,
      this.onChange,
        this.hintWidget,
      this.customButton,
      this.customItemsHeights})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonSplashColor: Colors.transparent,
        value: value,
        hint: hintWidget??TextApp(hint ?? ''),
        onMenuStateChange: (value) {},
        items: items,
        // itemPadding: EdgeInsets.zero,
        customItemsHeights: customItemsHeights,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        customButton: customButton,
        onChanged: (value) {
          onChange?.call(value);
        },
      ),
    );
  }
}
