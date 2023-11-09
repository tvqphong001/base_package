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

// ignore: camel_case_types
class height extends StatelessWidget {
  final double heightSize;
  const height(this.heightSize,{super.key});

  @override
  Widget build(BuildContext context) {
    return size(height: heightSize,);
  }
}

// ignore: camel_case_types
class width extends StatelessWidget {
  final double widthSize;
  const width(this.widthSize,{super.key});

  @override
  Widget build(BuildContext context) {
    return size(width: widthSize,);
  }
}


// ignore: camel_case_types
class spacer extends StatelessWidget {
  final int flex;
  const spacer(
      {Key? key,
      this.flex = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Spacer(
      flex: flex,
    );
  }
}
