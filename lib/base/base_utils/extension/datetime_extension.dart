import 'package:base_package/base/base.dart';
import 'package:intl/intl.dart';

final appDateFormat =DateFormat("dd/MM/yyyy", "vi_VI");
extension AppDateTime on DateTime {
  static final _shortDateFormat = DateFormat("dd/MM", "vi_VI");
  static final dateFormat = appDateFormat;
  static final _dateTabletFormat = DateFormat("dd/MM/yyyy | HH:mm", "vi_VI");
  static final _dateIso8601Format = DateFormat("yyyy-MM-dd",);
  static final _timeFormat = DateFormat("HH:mm:ss", "vi_VI");
  static final _dateTimeFormat = DateFormat("dd/MM/yyyy HH:mm:ss", "vi_VI");
  static final defaultValue = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime operator <<(Object? newValue) {
    if (newValue == null) {
      return defaultValue;
    } else if (newValue is DateTime) {
      return newValue;
    } else if (newValue is String) {
      return DateTime.tryParse(newValue) ?? defaultValue;
    } else if (newValue is int) {
      if (newValue > 0) {
        return DateTime.fromMillisecondsSinceEpoch(newValue);
      }
    }
    return defaultValue;
  }

  String get toUtcString => toUtc().toIso8601String();

  String get monthYear {
    return month.toString().padLeft(2, '0') +'/' + year.toString();
  }

  String get date {
    return dateFormat.format(this);
  }

  String get dateTablet {
    return _dateTabletFormat.format(this);
  }

  String get dateIso8601 {
    return _dateIso8601Format.format(this);
  }

  String get dateMonth {
    return _shortDateFormat.format(this);
  }

  String get dateTime {
    return _dateTimeFormat.format(this);
  }

  double toYears([DateTime? date]) {
    date ??= DateTime.now();
    var _aDate = DateTime(date.year, date.month, date.day);
    var _bDate = DateTime(year, month, day);
    var diffYear = (_aDate.year - _bDate.year).toDouble();
    if (diffYear < 0) {
      var _temp = _aDate;
      _aDate = _bDate;
      _bDate = _temp;
    }
    var daysToNextFullYear = _aDate
        .difference(DateTime(_aDate.year, _bDate.month, _bDate.day))
        .inDays;
    var _ = daysToNextFullYear / 365.0;
    diffYear += _;
    return diffYear;
  }

  String get onlyTime {
    return _timeFormat.format(this);
  }

  bool get isToDay{
    var now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate = DateTime(year, month, day);
    return today==aDate;
  }

  String titleDate(Locale locale) {
    if (locale.languageCode == 'vi') {
      return DateFormat('dd MMM yyyy', locale.languageCode).format(this);
    }
    return DateFormat('MMM dd yyyy', locale.languageCode).format(this);
  }

  String simpleDate1(Locale locale) {
    if (locale.languageCode == 'vi') {
      return DateFormat('dd/MM/yyyy', locale.languageCode).format(this);
    }
    return DateFormat('MM/dd/yyyy', locale.languageCode).format(this);
  }

}
