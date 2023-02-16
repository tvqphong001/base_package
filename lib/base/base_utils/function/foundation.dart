import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

bool get isWeb {
  return kIsWeb;
}

bool get isTablet {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide >= 550;
}

bool get isTabletOrWeb {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide >= 550 || isWeb;
}
