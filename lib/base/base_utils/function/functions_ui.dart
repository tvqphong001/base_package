import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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