import 'package:base_package/base/base.dart';

import 'dart:math' as math;

class NumberInputFormatter extends TextInputFormatter {

  final int minimum ;

  NumberInputFormatter({this.minimum = 0});
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.toInt < minimum){
      final text = minimum.toString();

      return newValue.copyWith(
          text: text,
          selection: TextSelection(
            baseOffset: math.min(newValue.selection.start, text.length),
            extentOffset: math.min(newValue.selection.end, text.length),
          ));
    }
    if (newValue.text.trim().isEmpty) {
      return const TextEditingValue(text: '0');
    }

    final text = newValue.text.toInt.toString();

    return newValue.copyWith(
        text: text,
        selection: TextSelection(
          baseOffset: math.min(newValue.selection.start, text.length),
          extentOffset: math.min(newValue.selection.end, text.length),
        ));
  }
}
