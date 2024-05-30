import 'dart:developer';

import 'package:intl/intl.dart';

import '../../base.dart';

export 'num_extensions.dart';
export 'string_extension.dart';
export 'datetime_extension.dart';
export 'page_controller_extension.dart';
export 'navigator.dart';
export 'context_extension.dart';
export 'iterable_extension.dart';
export 'color_extension.dart';
export 'textfield_extension.dart';
export 'validator_ex.dart';

const appCurrency = 'đ';
const maxMoney = 9.0071993e+15;

String formatToMoney(data,[bool? haveCurrency, String? mCurrency]) {
  var currency = haveCurrency??true ? (mCurrency??appCurrency) : '';
  try{
    int number = 0;
    if(data is String){
      number = int.tryParse(data.replaceAll('.', '').replaceAll(',', '').replaceAll(appCurrency, ''))??0;
    }else if(data is num){
      number = data.toInt();
    }


    if(number >= maxMoney) return '${numberFormat.format(maxMoney)}$currency';
    return '${numberFormat.format(number)}$currency';
  }catch(e){
    print('toMoney error $e');
    return '0$currency';
  }
}

String formatToMoneyLocale(data,{String? locale, String? symbol,bool hideSymbol = false}) {
  var numberFormat = NumberFormat.simpleCurrency(locale: locale,);
  try{
    var money = numberFormat.format(data);

    var symbols = numberFormat.currencySymbol;
    var moneyNoCurrency = money.replaceAll(symbols, '');
    if(moneyNoCurrency.toDouble == 0.0){
      money = NumberFormat.simpleCurrency(decimalDigits: 0,locale: locale).format(data);
      if(hideSymbol){
        money = money.replaceAll(symbols, '');
      }
      return money;
    }else{
      if(hideSymbol){
        money = money.replaceAll(symbols, '');
      }
    }

    RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");

    String s = money.toString().replaceAll(regex, '');

    return s;
  }catch(e,stack){
    log('formatToMoneyLocale error $e',stackTrace: stack);
    return numberFormat.format(0);
  }
}