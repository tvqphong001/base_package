import '../../base.dart';

extension NumEx on num{
  String toMoney([bool? haveCurrency, String? currency]) {
    return formatToMoney(this,haveCurrency,currency);
  }
}