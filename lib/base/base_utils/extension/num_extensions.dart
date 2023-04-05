import '../../base.dart';

extension NumEx on num{
  String toMoney([bool? haveCurrency, String? currency]) {
    return formatToMoney(this,haveCurrency,currency);
  }
}

extension NumExNull on num?{
  String toMoney([bool? haveCurrency, String? currency]) {
    return formatToMoney(this??0.0,haveCurrency,currency);
  }
}
