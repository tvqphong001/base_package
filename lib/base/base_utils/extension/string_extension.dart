import '../../base.dart';

extension StringExNull on String?{
  bool get isEmptyOrNull {
    if(this == null){
      return true;
    }

    return this!.isEmpty;
  }

  bool get isNotEmptyOrNull {
    if(this == null){
      return false;
    }

    return this!.isNotEmpty;
  }
}

extension StringEx on String{

  DateTime get date {
    return appDateFormat.parse(this);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String upperCaseFirst(){
    return capitalize();
  }

  String toMoney([bool? haveCurrency, String? currency]) {
    return formatToMoney(this,haveCurrency,currency);
  }

  int get moneyToInt{
    return int.tryParse(replaceAll(',', '').replaceAll('.', '').replaceAll(appCurrency, ''))??0;
  }

  double get moneyToDouble{
    return double.tryParse(replaceAll(',', '').replaceAll('.', '').replaceAll(appCurrency, ''))??0;
  }

  bool get isTrimEmpty {
    return trim().isEmpty;
  }
}
