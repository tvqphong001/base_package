//
// import 'package:digi_aqua2/base/base_app.dart';
// import 'package:digi_aqua2/modules/login/login.dart';
// import 'package:digi_aqua2/modules/splash/splash.dart';
//
// enum Routes {
//   Login,
//   Splash,
// }
//
// List<GetPage> routes() {
//   var list = <GetPage>[];
//
//   for (var element in Routes.values) {
//     list.add(_getWidget(element));
//   }
//
//   return list;
// }
//
// GetPage _getWidget(Routes element) {
//   final String routeName = element.routeName;
//   Widget page;
//   switch (element) {
//     case Routes.Login:
//       page = const Login();
//       break;
//     case Routes.Splash:
//       page = const Splash();
//       break;
//   }
//
//   return GetPage(name: routeName, page: () => page);
// }
//
// extension RoutesEx on Routes {
//   String get routeName => '/route_$name';
//   Future<T?>? push<T>({
//     dynamic arguments,
//     int? id,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//   }) async {
//     return await toNamed(
//         arguments: arguments,
//         id: id,
//         parameters: parameters,
//         preventDuplicates: preventDuplicates);
//   }
//
//
//   Future<T?>? toNamed<T>({
//     dynamic arguments,
//     int? id,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//   }) async {
//     return Get.toNamed(routeName,
//         arguments: arguments,
//         id: id,
//         parameters: parameters,
//         preventDuplicates: preventDuplicates);
//   }
//
//   Future<T?>? offNamed<T>({
//     dynamic arguments,
//     int? id,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//   }) async {
//     return Get.offNamed(routeName,
//         arguments: arguments,
//         id: id,
//         parameters: parameters,
//         preventDuplicates: preventDuplicates);
//   }
// }
