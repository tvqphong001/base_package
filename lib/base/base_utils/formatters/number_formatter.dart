import 'package:base_package/base/base.dart';

import 'dart:math' as math;

import '../validator/validators.dart';

// final currencyInputFormatter =  CurrencyTextInputFormatter.currency(locale: 'en',symbol: '',decimalDigits: 2,inputDirection: InputDirection.left);
final currencyInputFormatter =  CurrencyTextInputFormatter2();

class NumberInputFormatter extends TextInputFormatter {

  final int minimum ;

  const NumberInputFormatter({this.minimum = 0});
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

class CurrencyTextInputFormatter2 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    // deleting

    final split = newValue.text.split('.');
    if(split.length > 1) return newValue;
    if(newValue.text.isEmpty) return newValue;
    if(newValue.text.length < oldValue.text.length){
      String oldTextNumber = oldValue.text.replaceAll(RegExp('[^0-9]'), '').toMoney(false).replaceAll('.', ',').trim();
      String newValueNumber = newValue.text.replaceAll(RegExp('[^0-9]'), '').toMoney(false).replaceAll('.', ',').trim();

      String newText = newValue.text.toMoney(false).replaceAll('.', ',').trim();

      int subtractSelection = (oldTextNumber.length - newValueNumber.length) > 1 ? 1 : 0;

      return TextEditingValue(text: newText,selection: TextSelection.collapsed(offset: newValue.selection.baseOffset - subtractSelection,));
    }

    // not number
    if(!Validators.numberMoney.hasMatch(newValue.text)){
      return oldValue;
    }


    if(newValue.text[newValue.text.length -1] == '.'){
      return newValue;
    }


    if(split.length > 1){
      final index = newValue.text.indexOf('.');
      final baseOffset = newValue.selection.baseOffset;
      if(baseOffset <= index){
        final text = split[0];
        String oldTextNumber = text.replaceAll(RegExp('[^0-9]'), '');
        String newValueNumber = text.replaceAll(RegExp('[^0-9]'), '');

        String newText = text.toMoney(false).replaceAll('.', ',').trim();
        int countCommaDiff =(text.toMoney(false).replaceAll('.', ',').trim().length - newValueNumber.length) -  (oldValue.text.split('.')[0].length - oldTextNumber.length);
        newText = '$newText.${split[1]}';
        return TextEditingValue(text: newText,selection: TextSelection.collapsed(offset: newValue.selection.baseOffset + countCommaDiff -1,));
      }else {
        return newValue;
      }

    }else{
      String oldTextNumber = oldValue.text.replaceAll(RegExp('[^0-9]'), '');
      String newValueNumber = newValue.text.replaceAll(RegExp('[^0-9]'), '');

      String newText = newValue.text.toMoney(false).replaceAll('.', ',').trim();
      int countCommaDiff =(newValue.text.toMoney(false).replaceAll('.', ',').trim().length - newValueNumber.length) -  (oldValue.text.length - oldTextNumber.length);

      return TextEditingValue(text: newText,selection: TextSelection.collapsed(offset: newValue.selection.baseOffset + countCommaDiff,));
    }
  }
}