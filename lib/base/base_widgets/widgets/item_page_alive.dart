import '../../base.dart';

class ItemPageAlive extends StatefulWidget {
  final Widget child;
  const ItemPageAlive({Key? key, required this.child}) : super(key: key);

  @override
  State<ItemPageAlive> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPageAlive> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
