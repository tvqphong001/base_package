import 'package:base_package/base/base.dart';
import 'package:get/get.dart';

class ObxBuilder extends StatelessWidget {
  final Widget Function() builder;
  const ObxBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Obx(() => builder());
  }
}
