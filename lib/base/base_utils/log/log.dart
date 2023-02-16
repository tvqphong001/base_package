import 'dart:core' as core;

import 'package:flutter/foundation.dart';

export 'logger.dart';

void print(core.Object? object, {core.String? name}) {
  if (kDebugMode) {
    core.print(object);
    // logger.e(object);
  }
}

