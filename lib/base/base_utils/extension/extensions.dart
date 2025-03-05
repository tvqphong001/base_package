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
export 'dynamic_extension.dart';

const appCurrency = 'đ';
const maxMoney = 9.0071993e+15;

var thousandths = ',';
var decimalDigit = '.';

String formatToMoney(data,[bool? haveCurrency, String? mCurrency]) {
  var currency = haveCurrency??true ? (mCurrency??appCurrency) : '';
  try{
    int number = 0;
    if(data is String){
      number = int.tryParse(data.replaceAll(decimalDigit, '').replaceAll(thousandths, '').replaceAll(appCurrency, ''))??0;
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

    var moneyNoCurrency = money.replaceAll(symbols, '').replaceAll(thousandths, '');
    if(moneyNoCurrency.toDouble == 0.0){
      money = NumberFormat.simpleCurrency(decimalDigits: 0,locale: locale).format(data);

      // custom symbol
      if(symbol != null){
        var noSymbol = money.replaceAll(symbols, '');

        symbols = symbol;

        money = '$noSymbol $symbols';
      }

      if(hideSymbol){
        money = money.replaceAll(symbols, '').trim();
      }
      return money;
    }else{

      // custom symbol
      if(symbol != null){
        var noSymbol = money.replaceAll(symbols, '');

        symbols = symbol;

        money = '$noSymbol $symbols';
      }

      if(hideSymbol){
        money = money.replaceAll(symbols, '');
      }
    }

    RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");

    String s ='';
    if(numberFormat.locale == 'en_US' || numberFormat.locale == 'en'){
      s = money.toString().replaceAll(regex, '');
    }else{
      s = money;
    }

    return s;
  }catch(e,stack){
    log('formatToMoneyLocale error $e',stackTrace: stack);
    return numberFormat.format(0);
  }
}