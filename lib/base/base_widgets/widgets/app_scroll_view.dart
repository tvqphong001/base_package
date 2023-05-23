import '../../base.dart';
import 'dart:math' as math;

class AppScrollView extends StatelessWidget {
  final Widget child;
  const AppScrollView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShaderMask(
      child: SingleChildScrollView(
        padding: defaultShaderPadding,
        child: child,
      ),
    );
  }
}

class AppListView extends ListView{
  @override
  final SliverChildDelegate childrenDelegate;

  @override
  Widget build(BuildContext context) {
    return AppShaderMask(child: super.build(context));
  }

  AppListView.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    EdgeInsets? padding,
    super.itemExtent,
    super.prototypeItem,
    required NullableIndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  }) : assert(itemCount == null || itemCount >= 0),
        assert(semanticChildCount == null || semanticChildCount <= itemCount!),
        assert(
        itemExtent == null || prototypeItem == null,
        'You can only pass itemExtent or prototypeItem, not both.',
        ),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          findChildIndexCallback: findChildIndexCallback,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
        semanticChildCount: semanticChildCount ?? itemCount,
        padding: padding??defaultShaderPadding,
      );

  AppListView.separated({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    EdgeInsets? padding,
    required NullableIndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    required IndexedWidgetBuilder separatorBuilder,
    required int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    super.dragStartBehavior,
    double? itemExtent,
    Widget? prototypeItem,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  }) : assert(itemCount >= 0),

        childrenDelegate = SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            final Widget? widget;
            if (index.isEven) {
              widget = itemBuilder(context, itemIndex);
            } else {
              widget = separatorBuilder(context, itemIndex);
              assert(() {
                if (widget == null) {
                  throw FlutterError('separatorBuilder cannot return null.');
                }
                return true;
              }());
            }
            return widget;
          },
          findChildIndexCallback: findChildIndexCallback,
          childCount: _computeActualChildCount(itemCount),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (Widget _, int index) {
            return index.isEven ? index ~/ 2 : null;
          },
        ),
        super(
        semanticChildCount: itemCount,
          itemExtent:itemExtent,
          prototypeItem: prototypeItem,
        padding: padding??defaultShaderPadding,
      );
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }

   AppListView.custom({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    EdgeInsets? padding,
    double? itemExtent,
    Widget? prototypeItem,
    required this.childrenDelegate,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  }) : assert(
        itemExtent == null || prototypeItem == null,
        'You can only pass itemExtent or prototypeItem, not both',
        ), super(itemExtent: itemExtent,prototypeItem:prototypeItem,padding: padding??defaultShaderPadding,);
}
