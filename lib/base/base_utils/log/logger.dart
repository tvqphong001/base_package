import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(filter: _Log());

class _Log extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return !kReleaseMode;
  }
}
