import '../../base.dart';

export 'num_extensions.dart';
export 'string_extension.dart';
export 'datetime_extension.dart';
export 'page_controller_extension.dart';
export 'navigator.dart';
export 'context_extension.dart';

const appCurrency = 'đ';
const maxMoney = 2e7;

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