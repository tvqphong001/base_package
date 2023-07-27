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

String formatToMoneyLocale(data,{String? locale, String? symbol}) {
  // var currency = haveCurrency??true ? (mCurrency??appCurrency) : '';
  var numberFormat = NumberFormat.simpleCurrency(locale: locale/*,symbol: symbol*/,);
  try{
    // int number = 0;
    // if(data is String){
    //   number = int.tryParse(data.replaceAll('.', '').replaceAll(',', '').replaceAll(appCurrency, ''))??0;
    // }else if(data is num){
    //   number = data.toInt();
    // }




    var money = numberFormat.format(data);
    print(money);
    return money;
    // return numberFormat.format(number);
  }catch(e,stack){
    log('toMoney error $e',stackTrace: stack);
    return numberFormat.format(0);
  }
}