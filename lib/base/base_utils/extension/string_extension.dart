import '../../base.dart';
import 'package:diacritic/diacritic.dart';

extension StringExNull on String?{

  double get toDouble{
    return double.tryParse(this??'')??0.0;
  }
  String get removeDiacritic {
    return removeDiacritics(this??'');
  }

  String get removeDiacriticAndCase {
    return trimLowerCase;
  }

  String get trimLowerCase {
    if(this == null){
      return '';
    }

    return this!.trim().toLowerCase().removeDiacritic;
  }

  bool containsSearch(String textSearch){
    return this.removeDiacriticAndCase.contains(textSearch.removeDiacriticAndCase);
  }

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

  int get toInt {
    return int.tryParse(this??'')??0;
  }

  String get toPercentString{
    if(this == null){
      return '0';
    }

    final a = this.toDouble.toInt().toDouble();
    final b = this.toDouble;
    if(a == b){
      return a.toInt().toString();
    }else{
      return b.toString();
    }
  }
}

extension StringEx on String{

  DateTime get date {
    return appDateFormat.parse(this);
  }

  String capitalize() {
    if(this.isEmpty) return '';
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

  num get moneyToNum{
    var money =  num.tryParse(replaceAll(',', ''))??0;
    return money;
  }

  bool get isTrimEmpty {
    return trim().isEmpty;
  }
}
