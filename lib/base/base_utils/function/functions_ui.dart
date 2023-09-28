import 'package:base_package/base/base.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

bool hasTextOverflow(
    String text,
    TextStyle style,
    {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2
    }) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: minWidth, maxWidth: maxWidth);

  return textPainter.didExceedMaxLines;
}

double getWidthText(
    String text,
    TextStyle style,
    {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2
    }) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: minWidth, maxWidth: maxWidth);

  return textPainter.width;
}

showToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xff838283),
      textColor: Colors.white,
      fontSize: 24.0
  );
}

showSnackBarGet(String message,{BuildContext? context}){
  Get.showSnackbar(GetSnackBar(
    // title: 'Alert!!',
    // message: message,
    snackPosition: SnackPosition.BOTTOM,
    messageText: TextApp(message,textAlign: TextAlign.center,color: Colors.white),
    duration: const Duration(seconds: 2),
    margin: EdgeInsets.only(bottom: 100,right: 20,left: 20),
    // snackStyle: SnackStyle.GROUNDED,
    backgroundGradient: LinearGradient(
      begin: Alignment(1.00, 0.06),
      end: Alignment(-1, -0.06),
      colors: [
        Color(0xFF306C9D),
        Color(0xFF00304D),
      ],
    ),
    borderRadius: 14,
    // backgroundColor: Theme.of(context??Get.context!).primaryColor,
  ));
}


final rnd = math.Random();

Color get getRandomColor => Color(rnd.nextInt(0xffffffff));