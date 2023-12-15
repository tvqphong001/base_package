//
// import 'package:base_package/base/base.dart';
// import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
//
// extension StateExt2<T> on StateMixin<T> {
//   Widget obxCustom(
//       NotifierBuilder<T> widget, {
//         Widget Function(String? error)? onError,
//         VoidCallback? tryAgain,
//         VoidCallback? tryAgainEmpty,
//         Widget? loadingWidget,
//         Widget? emptyWidget,
//         String? titleEmpty,
//         String? descriptionEmpty,
//         bool onlyShowWidget = false, // no show loading, empty, error
//         T? initState , // when onlyShowWidget = true need initState
//         // SmartRefresherWidget
//         RefreshController? refreshController,
//         Function()? onLoading,
//         Function()? onRefresh,
//         bool? enablePullDown = true,
//         bool? enablePullUp = true,
//       }) {
//     return SimpleBuilder(builder: (_) {
//       Widget? child;
//       if(onlyShowWidget){
//         return widget(state??initState!);
//       }
//       if (status.isLoading ) {
//         return loadingWidget ?? const Center(child: CircularProgressIndicator());
//       } else if (status.isError) {
//         child = onError != null
//             ? onError(status.errorMessage)
//             : MyErrorWidget(
//           error: status.errorMessage,
//           tryAgain: tryAgain,
//         );
//       } else if (status.isEmpty || state == null) {
//         child = emptyWidget ??
//             EmptyWidget(
//               tryAgain: tryAgainEmpty,
//               title: titleEmpty,
//               description: descriptionEmpty,
//             ); // Also can be widget(null); but is risky
//       }else{
//         child = widget(state!);
//       }
//
//
//       if (refreshController == null) {
//         return child;
//       }
//       return SmartRefresherWidget(
//         refreshController: refreshController,
//         onLoading: onLoading,
//         onRefresh: onRefresh,
//         enablePullUp: enablePullUp,
//         enablePullDown: enablePullDown,
//         child: child,
//       );
//     });
//   }
// }
