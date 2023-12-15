import 'base.dart';

// abstract class BaseRepository implements BaseHttpService{
//   final httpClient = getIt<BaseHttpService>(instanceName: 'ApiService');
//
//   @override
//   Future<Response?> get({required String path, Options? options}) {
//     return httpClient.get(path: path);
//   }
//
//   @override
//   Future<Response?> post({required String path, Options? options}) {
//     return httpClient.post(path: path);
//   }
// }

// void configDependencyHttpService(String baseUrl) {
//   getIt.registerSingletonAsync(() => RestApiService.init(baseUrl),instanceName: 'ApiService');
// }
//
