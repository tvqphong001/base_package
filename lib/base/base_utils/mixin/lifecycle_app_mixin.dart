import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin LifecycleAppMixin<T extends StatefulWidget> on State<T> {
  late LifecycleEventHandler _lifecycle;
  bool _isReady = false;

  bool get isReady => _isReady;

  @override
  void initState() {
    super.initState();
    _lifecycle = LifecycleEventHandler(
        inactive: inactive, resume: resume, paused: paused, detached: detached);
    WidgetsBinding.instance.addObserver(_lifecycle);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isReady = true;
      onReady(_);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycle);
    super.dispose();
  }

  void onReady(_) {}

  Future inactive() async {}

  Future resume() async {}

  Future paused() async {}

  Future detached() async {}
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler(
      {this.resume, this.inactive, this.paused, this.detached});

  final AsyncCallback? resume;
  final AsyncCallback? inactive;
  final AsyncCallback? paused;
  final AsyncCallback? detached;

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        await inactive?.call();
        break;
      case AppLifecycleState.paused:
        await paused?.call();
        break;
      case AppLifecycleState.detached:
        await detached?.call();
        break;
      case AppLifecycleState.resumed:
        await resume?.call();
        break;
    }
  }
}