import 'package:flutter/scheduler.dart';

import '../../base.dart';

void hideKeyBoard([BuildContext? context]){
  FocusScopeNode currentFocus = FocusScope.of(context??currentContext);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

void onWidgetBuildDone(function) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
  function();
  });
}