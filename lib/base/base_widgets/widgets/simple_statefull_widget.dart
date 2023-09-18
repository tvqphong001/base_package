import 'package:base_package/base/base.dart';

class PageStateful extends StatefulWidget {
  final Widget child;
  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  const PageStateful({Key? key, required this.child, this.onInit, this.onDispose})
      : super(key: key);

  @override
  State<PageStateful> createState() => _PageStatefulState();
}

class _PageStatefulState extends State<PageStateful> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
