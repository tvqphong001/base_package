import 'package:base_package/base/base.dart';

class ExpansionTileApp extends StatefulWidget {
  final List<Widget> children;
  final bool initiallyExpanded;
  final String title;
  const ExpansionTileApp({Key? key, required this.children,  this.initiallyExpanded = true, required this.title}) : super(key: key);

  @override
  State<ExpansionTileApp> createState() => _ExpansionTileAppState();
}

class _ExpansionTileAppState extends State<ExpansionTileApp> {
  late bool isExpanded = widget.initiallyExpanded;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      initiallyExpanded: widget.initiallyExpanded,
      trailing: const SizedBox(),
      title: Row(
        children: <Widget>[
          TextApp(
            widget.title,
            fontWeight: FontWeight.w700,
          ),
          Icon(
            isExpanded
                ? Icons.arrow_drop_up_outlined
                : Icons.arrow_drop_down_outlined,
            color: Colors.black,
          ),
        ],
      ),
      children: widget.children,
    );
  }
}
