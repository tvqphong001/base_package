import '../../base.dart';

extension NumEx on num{
  String toMoney([bool? haveCurrency, String? currency]) {
    return formatToMoney(this,haveCurrency,currency);
  }

  String toMoneyLocale({String? locale, String? symbol, bool hideSymbol = false}) {
    return formatToMoneyLocale(this,locale: locale,symbol: symbol,hideSymbol: hideSymbol);
  }
}

const zeroStr = '0';

extension NumExNull on num?{
  String toMoney([bool? haveCurrency, String? currency]) {
    return formatToMoney(this??0.0,haveCurrency,currency);
  }

  String toStringSafe({String? defaultValue}){
    if(this == null) return defaultValue??'';
    return this.toString();
  }

  bool get isZeroOrNull{
    return this == null || this == 0;
  }

  bool get isNotZeroOrNull{
    return !isZeroOrNull;
  }

  num get toNum{
    final split = this.toString().split(decimalDigit);

    if(split.length >= 2){
      if(split[1].isEmpty || split[1] == '0'){
        return split[0].toInt;
      }
    }

    return this??0;
  }
}
