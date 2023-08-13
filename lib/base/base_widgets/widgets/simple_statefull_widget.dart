import 'package:base_package/base/base.dart';

class PageStateful extends StatefulWidget {
  final Widget child;
  final VoidCallback onInit;
  const PageStateful({Key? key, required this.child, required this.onInit})
      : super(key: key);

  @override
  State<PageStateful> createState() => _PageStatefulState();
}

class _PageStatefulState extends State<PageStateful> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
