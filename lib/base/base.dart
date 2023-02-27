library base_package;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
// base
export 'base_widgets/base_widgets.dart';
export 'base_utils/base_utils.dart';
export 'base_constants.dart';
export 'base_http_service/base_service.dart';
export 'base_repository.dart';
// -----

// packages
export 'package:dio/dio.dart';
export 'package:equatable/equatable.dart';
export 'package:collection/collection.dart';
export 'package:copy_with_extension/copy_with_extension.dart';
export 'package:json_annotation/json_annotation.dart';

// build-in packages
export 'dart:io';
export 'package:flutter/material.dart' hide RefreshIndicator;
export 'package:flutter_svg/flutter_svg.dart';
export 'package:flutter/services.dart';
export 'package:url_launcher/url_launcher.dart';


// global func and parameter
final getIt = GetIt.instance;
var numberFormat = NumberFormat('#,###', 'vi_VN');
final navigatorKey = GlobalKey<NavigatorState>();
final routeObserver = RouteObserver<PageRoute>();

BuildContext get currentContext => navigatorKey.currentContext!;
TextTheme get textTheme => Theme.of(currentContext).textTheme;