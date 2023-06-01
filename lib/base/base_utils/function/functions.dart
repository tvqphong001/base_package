import '../../base.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

export 'functions_foundation.dart';
export 'functions_ui.dart';
export 'functions_router.dart';
export 'functions_system.dart';

void hideKeyBoard([BuildContext? context]) {
  FocusScopeNode currentFocus = FocusScope.of(context ?? ScreenHelper.context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

String formatCurrency(num currency, {String unitCurrency = 'đ'}) {
  final formatCurrency = NumberFormat("#,##0");
  var formatted = formatCurrency.format(currency);
  return '$formatted $unitCurrency';
}

int subTotal(List<int> prices) {
  int subTotal;
  if (prices.isNotEmpty) {
    subTotal = prices.reduce((a, b) => a + b);
    return subTotal;
  } else {
    subTotal = 0;
  }
  return subTotal;
}

void onWidgetBuildDone(function) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    function();
  });
}

removeNull(Map<String, dynamic> data) {
  return data.removeWhere((key, value) => value == null);
}

String formatTimeZone(String dateTime) {
  final DateTime convertToDateTime =
      DateTime.tryParse(dateTime)!.toUtc().toLocal();
  var formatter =
      DateFormat('yyyy-MM-dd HH:mm', const Locale('en').languageCode);
  var formatted = formatter.format(convertToDateTime);
  return formatted;
}

String getSourceNameDevice() {
  if (kIsWeb) {
    return 'WEB';
  } else if (Platform.isAndroid) {
    return 'ANDROID';
  } else if (Platform.isIOS) {
    return 'IOS';
  }
  return 'UNKNOW';
}

String formatChartDate(String dateTime) {
  final DateTime convertToDateTime =
      DateTime.tryParse(dateTime)!.toUtc().toLocal();
  var formatter = DateFormat('d/MM', const Locale('en').languageCode);
  var formatted = formatter.format(convertToDateTime);
  return formatted;
}

String formatDateRange(DateTime dateTime) {
  var formatter = DateFormat('dd/MM/yyyy', const Locale('en').languageCode);
  var formatted = formatter.format(dateTime);
  return formatted;
}

String formatMonth(DateTime dateTime) {
  var formatter = DateFormat('MMMM / yyyy', const Locale('en').languageCode);
  var formatted = formatter.format(dateTime);
  return formatted;
}

String formatRangeSaleReport(DateTime dateTime) {
  var formatter = DateFormat('d/M/yy', const Locale('en').languageCode);
  var formatted = formatter.format(dateTime);
  return formatted;
}

bool checkValidDate({String format = 'dd/MM/yyyy', required String input}) {
  try {
    DateFormat(format).parseStrict(input);
    return true;
  } catch (e) {
    return false;
  }
}

DateTime parseStrictDate(
    {String format = 'dd/MM/yyyy', required String input}) {
  return DateFormat(format).parseStrict(input);
}

DateTime toZeroTime(DateTime time) =>
    DateTime(time.year, time.month, time.day, 0);

void configUI([bool enablePortraitUp = true]) {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: SystemUiOverlay.values);
  if (enablePortraitUp) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }else{
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.landscapeRight,DeviceOrientation.landscapeLeft,]);
  }
}

List chunkList(List data, {int chunkSize = 2}) {
  List chunks = [];
  for (var i = 0; i < data.length; i += chunkSize) {
    chunks.add(data.sublist(
        i, i + chunkSize > data.length ? data.length : i + chunkSize));
  }
  return chunks;
}
