import 'base.dart';
import 'base_http_service/rest_api_service.dart';

abstract class BaseRepository {
  final httpClient = getIt<RestApiService>();
}
