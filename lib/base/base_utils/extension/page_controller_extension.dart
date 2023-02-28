import 'package:flutter/material.dart';

extension PageControllerEx on PageController {
  void animate2Page(int page) {
    animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  int get page2Int => page?.toInt()??0;

  void animateToNexPage(){
    var p = (page?.toInt()??0)+1;
    animate2Page(p);
  }

  void animateToPreviousPage(){
    var p = (page?.toInt()??0)-1;
    animate2Page(p);
  }
}

class ChangeNotifierBuilder<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierBuilder({
    Key? key,
    required this.value,
    required this.builder,
  }) : super(key: key);

  final T value;

  final Widget Function(BuildContext context, T value) builder;

  @override
  _ChangeNotifierBuilderState<T> createState() =>
      _ChangeNotifierBuilderState<T>();
}

class _ChangeNotifierBuilderState<T extends ChangeNotifier>
    extends State<ChangeNotifierBuilder<T>> {
  @override
  void initState() {
    widget.value.addListener(_listener);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierBuilder<T> oldWidget) {
    if (widget.value != oldWidget.value) {
      _miggrate(widget.value, oldWidget.value, _listener);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.value.removeListener(_listener);
    super.dispose();
  }

  void _miggrate(Listenable a, Listenable b, void Function() listener) {
    b.removeListener(listener);
    a.addListener(listener);
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.value);
  }
}