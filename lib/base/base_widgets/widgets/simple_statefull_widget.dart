import 'package:base_package/base/base.dart';

class PageStatefull extends StatefulWidget {
  final Widget child;
  final VoidCallback onInit;
  const PageStatefull({Key? key, required this.child, required this.onInit})
      : super(key: key);

  @override
  State<PageStatefull> createState() => _PageStatefullState();
}

class _PageStatefullState extends State<PageStatefull> {
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
