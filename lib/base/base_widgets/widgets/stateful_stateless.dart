// import '../base.dart';
//
// abstract class BaseGetState<T extends StatefulWidget, G extends GetxController> extends State<T>{
//   G get controller => Get.find<G>();
// }
//
// abstract class KeepAliveGetState<T extends StatefulWidget, G extends GetxController> extends State<T> with AutomaticKeepAliveClientMixin{
//   G get controller => Get.find<G>();
//
//   @override
//   bool get wantKeepAlive => true;
// }
//
// abstract class KeepAliveState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin{
//   @override
//   bool get wantKeepAlive => true;
// }
//
// abstract class BaseGetView<T extends GetxController> extends GetView<T> {
//   const BaseGetView({Key? key}) : super(key: key);
//
//   // T initController();
//
//   @override
//   Widget build(BuildContext context) {
//     // Get.put(initController());
//
//     return buildBody(context);
//   }
//
//   Widget buildBody(BuildContext context);
// }