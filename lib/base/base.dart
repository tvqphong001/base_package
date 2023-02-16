library base;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mpos/constants/app_constants.dart';

// base
export 'base_widgets/base_widgets.dart';
export 'base_utils/base_utils.dart';
export '../utils/services/storage_service.dart';
export 'base_constants.dart';
// -----

// packages
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:dio/dio.dart';
export 'package:equatable/equatable.dart';
export 'package:collection/collection.dart';
export 'package:copy_with_extension/copy_with_extension.dart';

// build-in packages
export 'dart:io';
export 'package:flutter/material.dart' hide RefreshIndicator;
export 'package:flutter_svg/flutter_svg.dart';
export 'package:flutter/services.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';
export 'package:get_storage/get_storage.dart';
export 'package:thermal_printer/thermal_printer.dart';

// in app
import 'package:mpos/app/app_manager.dart';

export '../config/routes/routes.dart';
export '../config/theme/colors_app.dart';
export '../app/app_manager.dart';
export '../base/base_widgets/app_text.dart';
export '../base/base_widgets/text_form_field.dart';
export '../base/base_widgets/app_button.dart';
export 'package:mpos/library/models/models.dart';
export 'package:mpos/widgets/widgets.dart';
export 'package:mpos/utils/utils.dart';

// this for tablet, web
export 'package:go_router/go_router.dart';
// global func and parameter
const paddingApp = 16.0;
const pageSize = '15';
final getIt = GetIt.instance;
var numberFormat = NumberFormat('#,###', 'vi_VN');
final navigatorKey = GlobalKey<NavigatorState>();
final routeObserver = RouteObserver<PageRoute>();
AppLocalizations get language => AppLocalizations.of(currentContext)!;
BuildContext get currentContext => App.context!;
BuildContext get appContext => App.context!;
TextTheme get textTheme => Theme.of(currentContext).textTheme;
// List get multiBlocProvider =>
//     (((ModalRoute.of(currentContext)?.settings.arguments ?? {}) as Map<String, dynamic>)[argurmentKeyBlocProvider] ??
//         []);
