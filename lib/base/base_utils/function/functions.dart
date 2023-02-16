import 'dart:ui' as ui;

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image/image.dart' as Imag;
import 'package:intl/intl.dart';
import 'package:mpos/constants/assets_path.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../base.dart';

export 'foundation.dart';
export 'ui.dart';

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
  final DateTime convertToDateTime = DateTime.tryParse(dateTime)!.toUtc().toLocal();
  var formatter = DateFormat('yyyy-MM-dd HH:mm', const Locale('en').languageCode);
  var formatted = formatter.format(convertToDateTime);
  return formatted;
}

String getSourceNameDevice() {
  if(kIsWeb){
    return 'WEB';
  }
  else if (Platform.isAndroid) {
    return 'ANDROID';
  } else if (Platform.isIOS) {
    return 'IOS';
  }
  return 'UNKNOW';
}

String formatChartDate(String dateTime) {
  final DateTime convertToDateTime = DateTime.tryParse(dateTime)!.toUtc().toLocal();
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

DateTime parseStrictDate({String format = 'dd/MM/yyyy', required String input}) {
  return DateFormat(format).parseStrict(input);
}

DateTime toZeroTime(DateTime time) => DateTime(time.year, time.month, time.day, 0);

void configLoading() {
  EasyLoading.instance
    ..indicatorWidget = AppImage.asset(Images.loading.icLoading, height: 100, width: 100)
    ..indicatorColor = Colors.transparent
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.transparent
    ..backgroundColor = Colors.transparent
    ..boxShadow = []
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = ColorsApp.wiserink40.withOpacity(0.5);
}

void configUI([bool enablePortraitUp = true]) {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: SystemUiOverlay.values);
  if(enablePortraitUp){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

List chunkList(List data) {
  List chunks = [];
  int chunkSize = 2;
  for (var i = 0; i < data.length; i += chunkSize) {
    chunks.add(data.sublist(i, i + chunkSize > data.length ? data.length : i + chunkSize));
  }
  return chunks;
}

Future printReceipt(GlobalKey repaintBoundaryKey, {bool showLoading = true}) async {
  try {
    // if (showLoading) EasyLoading.show();
    // final sdk = ThermalPrinter();
    // sdk.initPrinter((value) {
    //   print(value);
    // });
    // if (showLoading) EasyLoading.show();
    // RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // ui.Image image = await boundary.toImage();
    // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List pngBytes = byteData!.buffer.asUint8List();
    // await sdk.startPrinter(pngBytes);
    // EasyLoading.dismiss();
    await PermissionHelper.checkBluetoothPermission(
      () async {
        if (showLoading) EasyLoading.show();
        final profile = await CapabilityProfile.load();
        final ticket = Generator(PaperSize.mm58, profile);
        List<int> receipt = [];
        RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage();
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        final receiptImage = Imag.decodeImage(pngBytes);
        receipt += ticket.imageRaster(receiptImage!);
        receipt += ticket.feed(3);

        // Print Receipt
        await PrintBluetoothThermal.disconnect;
        final List<BluetoothInfo> connectedDevices = await PrintBluetoothThermal.pairedBluetooths;
        if (connectedDevices.where((device) => device.name == 'CS50 Printer').isNotEmpty) {
          BluetoothInfo cs50 = connectedDevices.firstWhere((device) => device.name == 'CS50 Printer');
          await PrintBluetoothThermal.connect(macPrinterAddress: cs50.macAdress);
          bool connected = await PrintBluetoothThermal.connectionStatus;
          print(connected);
          if (connected) {
            await PrintBluetoothThermal.writeBytes(receipt);
            await PrintBluetoothThermal.disconnect;
          }
        }
        EasyLoading.dismiss();
      },
    );
  } catch (e) {
    EasyLoading.dismiss();
  }
}

void pushToPayment([argument]) {
  Routes.payment.push(arguments: argument);
}
