import 'package:base_package/base/base.dart';

mixin GetxScrollMixin on GetxController{

  final scrollController = ScrollController();

  scrollToEnd(){
    delay(duration: Duration(
      milliseconds: 50
    ),callBack: () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: defaultDuration, curve: Curves.easeOutCubic);
    });
  }
}