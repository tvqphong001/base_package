import 'package:dropdown_below/dropdown_below.dart';
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
  final EdgeInsets? buttonPadding;
  final EdgeInsets? itemPadding;
  // final bool _colItem;
  //
  // const AppDropDownButton.colItem({
  //   Key? key,
  //   this.hint,
  //   this.value,
  //   required this.items,
  //   this.onChange,
  //   this.hintWidget,
  //   this.customButton,
  //   this.customItemsHeights
  //   }) : _colItem = true;

  const AppDropDownButton(
      {Key? key,
      this.hint,
      this.value,
      required this.items,
      this.onChange,
        this.hintWidget,
      this.customButton,
      this.customItemsHeights,
      this.buttonPadding,
      this.itemPadding})
      :  super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(

      child: DropdownButton2(
        buttonWidth: double.infinity,
        // dropdownPadding: EdgeInsets.zero,
        // buttonPadding: EdgeInsets.zero,
        buttonPadding: buttonPadding??EdgeInsets.symmetric(horizontal: 20),
        // itemPadding: EdgeInsets.zero,
        itemPadding: itemPadding??EdgeInsets.symmetric(horizontal: 20),

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

class DropDownData<T> extends Equatable {
  final String text;
  final T data;

  const DropDownData(this.text, this.data);

  @override
  List<Object?> get props => [text];
}

class DropDownBelowButton<T> extends StatelessWidget {
  final DropDownData<T> value;
  final List<DropDownData<T>> listValue;
  final Function(DropDownData<T>) onChange;
  final TextStyle? textStyle;
  final double? width;
  const DropDownBelowButton(
      {Key? key,
        required this.value,
        required this.listValue,
        required this.onChange, this.textStyle, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      child: DropdownBelow<DropDownData<T>?>(
        itemWidth: width,
        itemTextstyle: textStyle,
        icon: const Icon(
          Icons.arrow_drop_down,
        ),
        boxTextstyle: const TextStyle(
          fontSize: 14,

        ),
        hint: Container(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: TextApp(
            value.text,
            style: textStyle,
          ),
        ),
        boxWidth: width,
        value: value,

        items: listValue.map((prefix) {
          return DropdownMenuItem<DropDownData<T>?>(
            value: prefix,
            child: TextApp(
              prefix.text ?? '',
              style: textStyle,
            ),
          );
        }).toList(),
        onChanged: (value){
          if(value!=null){
            onChange(value);
          }
        },
      ),
    );
  }
}
