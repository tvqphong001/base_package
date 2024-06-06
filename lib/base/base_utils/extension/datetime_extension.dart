import 'package:base_package/base/base.dart';
import 'package:intl/intl.dart';

extension DateTimeBaseEx on DateTime? {

  String? get toUtcString => this?.toUtc().toIso8601String();
  String get toStringUtcIso8601String => this?.toUtc().toIso8601String()??'';

  String? get dateIso8601 {
    if(this == null) return null;
    return DateFormat("yyyy-MM-dd").format(this!);
  }
}

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

  DateTime get startTimeOfDate {
    return DateTime(year,month,day);
  }

  DateTime get endTimeOfDate {
    return startTimeOfDate.add(const Duration(days: 1)).subtract(const Duration(microseconds: 1));
  }

  bool get isDayOfWeek{
    return _startTimeOfWeek.millisecondsSinceEpoch <= this.millisecondsSinceEpoch && this.millisecondsSinceEpoch <= _endTimeOfWeek.millisecondsSinceEpoch;
  }

  DateTime get startTimeOfWeek{
    final startOfWeek = getDate(this.subtract(Duration(days: this.weekday - 1)));
    return startOfWeek;
  }

  DateTime get _startTimeOfWeek{
    final now = DateTime.now();
    final startOfWeek = getDate(now.subtract(Duration(days: now.weekday - 1)));
    return startOfWeek;
  }

  DateTime get _endTimeOfWeek{
    final now = DateTime.now();
    final endOfWeek = getDate(now.add(Duration(days: DateTime.daysPerWeek - now.weekday))).endTimeOfDate;
    return endOfWeek;
  }

  DateTime get endTimeOfWeek{
    final endOfWeek = getDate(this.add(Duration(days: DateTime.daysPerWeek - this.weekday))).endTimeOfDate;
    return endOfWeek;
  }
}

DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

String get timeId => '_${DateTime.now().millisecondsSinceEpoch.toString()}';
String get timeIdString => '${DateTime.now().millisecondsSinceEpoch.toString()}';
int get timeIdInt => DateTime.now().millisecondsSinceEpoch;