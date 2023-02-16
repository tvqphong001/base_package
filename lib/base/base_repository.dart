import 'package:mpos/utils/services/rest_api_service.dart';

import 'base.dart';

abstract class BaseRepository {
  final httpClient = getIt<RestApiService>();
}
