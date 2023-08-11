import 'dart:async';

import 'package:base_package/base/base.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TabBarScrollViewWidget extends StatefulWidget {
  final List<Widget> children;
  final List<String> listTitleTabBar;
  final TabController? tabController;
  final RefreshController? refreshController;
  final VoidCallback? onRefresh;
  final bool? enablePullDown;
  final EdgeInsets? paddingTabbar;
  final EdgeInsets? paddingListView;
  final Color? tabbarTextColorActive;
  final double? cacheExtent;
  const TabBarScrollViewWidget({
    super.key,
    required this.children,
    this.tabController,
    required this.listTitleTabBar,
    this.onRefresh,
    this.refreshController, this.enablePullDown, this.paddingTabbar, this.tabbarTextColorActive, this.paddingListView, this.cacheExtent,
  }) : assert(children.length == listTitleTabBar.length);

  @override
  State<TabBarScrollViewWidget> createState() => _TabBarListViewWidgetState();
}

class _TabBarListViewWidgetState extends State<TabBarScrollViewWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final autoScrollController = AutoScrollController();

  late final refreshController =
      widget.refreshController ?? RefreshController();
  bool blockScroll = false;

  Timer? timerBlockScroll;

  var mapVisibleObj = <int,double>{};
  var maxIndex = 0;
  @override
  void initState() {
    tabController = widget.tabController ??
        TabController(length: widget.children.length, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    timerBlockScroll?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChangeNotifierBuilder<TabController>(
            value: tabController,
            builder: (context, value) {
              return TabBar(
                controller: tabController,
                onTap: (index) {
                  blockScroll = true;
                  autoScrollController.scrollToIndex(index,
                      preferPosition: AutoScrollPosition.begin);
                  timerBlockScroll?.cancel();
                  timerBlockScroll =
                      Timer(const Duration(milliseconds: 600), () {
                    blockScroll = false;
                  });
                },
                padding: widget.paddingTabbar??const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                isScrollable: true,
                indicatorWeight: 2,
                tabs: widget.listTitleTabBar
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextApp(
                              e,
                              color: value.index ==
                                      widget.listTitleTabBar.indexOf(e)
                                  ? widget.tabbarTextColorActive??Colors.blue
                                  : null),
                        ))
                    .toList(),
              );
            }),
        Expanded(
          child: SmartRefresher(
            controller: refreshController,
            onRefresh: widget.onRefresh,
            enablePullDown: widget.enablePullDown??false,
            enablePullUp: false,
            child: ListView(
              padding: widget.paddingListView?.copyWith(bottom: 30) ??const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30
              ),
              cacheExtent: widget.cacheExtent??99999,
              controller: autoScrollController,
              children: widget.children.map((e) {
                var index = widget.children.indexOf(e);
                return VisibilityDetector(
                  key: Key('Visibility$index'),
                  onVisibilityChanged: (VisibilityInfo info) {
                    try {
                      mapVisibleObj[index] = info.visibleFraction;

                      mapVisibleObj.forEach((index, value) {
                        var valueMax = mapVisibleObj[maxIndex]!;
                        if(value >= valueMax){
                          maxIndex = index;
                        }
                      });

                      if (tabController.index != maxIndex &&
                          !blockScroll) {
                        tabController.animateTo(maxIndex);
                      }
                    } catch (e, stack) {
                      log(e, stackTrace: stack);
                    }
                  },
                  child: AutoScrollTag(
                    key: Key(index.toString()),
                    controller: autoScrollController,
                    index: index,
                    child: e,
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
