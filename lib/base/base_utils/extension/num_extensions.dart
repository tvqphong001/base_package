import '../../base.dart';

extension NumEx on num{
  String toMoney([bool? haveCurrency, String? currency]) {
    return formatToMoney(this,haveCurrency,currency);
  }

  String toMoneyLocale({String? locale, String? symbol, bool hideSymbol = false}) {
    return formatToMoneyLocale(this,locale: locale,symbol: symbol,hideSymbol: hideSymbol);
  }
}

extension NumExNull on num?{
  String toMoney([bool? haveCurrency, String? currency]) {
    return formatToMoney(this??0.0,haveCurrency,currency);
  }
}
