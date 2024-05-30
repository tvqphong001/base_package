import 'dart:core' as core;

import 'package:flutter/foundation.dart';

export 'logger.dart';

void print(core.Object? object, {core.String? name, core.bool printOnRelease = false}) {
  if (kDebugMode || printOnRelease) {
    core.print(object);
    // logger.e(object);
  }
}

