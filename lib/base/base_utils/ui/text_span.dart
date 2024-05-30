import 'package:base_package/base/base.dart';
import 'package:flutter/gestures.dart';

TapGestureRecognizer onTapTextSpan({ VoidCallback? onTap}){
  return TapGestureRecognizer()..onTap = () => onTap?.call();
}