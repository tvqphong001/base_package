import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
final ScreenHelper = _ScreenHelper();


class _ScreenHelper {
  late BuildContext context;
  var _designWidth = 375.0;
  var _designHeight = 375.0;
  init(BuildContext initContext,{double? designWidth, double? designHeight}){
    context = initContext;
    var media = MediaQuery.of(context);
    portraitStatusBar = media.padding.top;
    portraitHeight = media.size.height;
    portraitWidth = media.size.width;

    _designWidth = designWidth?? 375.0;
    _designHeight = designHeight?? 375.0;
  }

  double portraitStatusBar = 0;
  double portraitHeight = 0;
  double portraitWidth = 0;
  double get statusBar => MediaQuery.of(context).padding.top;
  double get bottomBar => MediaQuery.of(context).padding.bottom;

  double getSsp(double size) {
    double screenSize = (size / _designWidth) * MediaQuery.of(context).size.width;

    if (screenSize >= size) {
      screenSize = size;
    }

    return screenSize;
  }

  double get appbar => 69 + statusBar;

  double get bottomNavigation => 63.0;

  double get heightScreen => MediaQuery.of(context).size.height;
  double get widthScreen => MediaQuery.of(context).size.width;
  double get centerScreen => (ScreenHelper.heightScreen - ScreenHelper.statusBar - ScreenHelper.bottomBar - 69 * 2) / 2;
}

extension ScreenHelperEx on num {
  double get toHPercent => (ScreenHelper.heightScreen / 100) * this;
  double get toWPercent => (ScreenHelper.widthScreen / 100) * this;

  double get widthToPercent => (ScreenHelper.widthScreen * this) / ScreenHelper._designWidth;
  double get heightToPercent => (ScreenHelper.heightScreen * this) / ScreenHelper._designHeight;
}