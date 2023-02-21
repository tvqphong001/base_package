import 'base.dart';

abstract class BaseRepository {
  final httpClient = getIt<RestApiService>();
}
