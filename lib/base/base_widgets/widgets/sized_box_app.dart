import 'package:base_package/base/base.dart';

// ignore: camel_case_types
class size extends StatelessWidget {
  final double height;
  final double width;
  final double? sized;
  final Widget? child;
  const size(
      {Key? key, this.height = 0, this.width = 0, this.sized, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sized ?? width,
      height: sized ?? height,
      child: child,
    );
  }
}
