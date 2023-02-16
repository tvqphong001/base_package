import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../base.dart';

class RefreshLoadMoreWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onRefresh;
  final Function(int)? onLoading;
  final VoidCallback? initWidget;
  final bool loadingWhenInit;
  final bool activeLoadMore;
  final int initPage;
  final bool isLast;
  final bool refreshOnly;

  const RefreshLoadMoreWidget(
      {Key? key,
      this.activeLoadMore = true,
      required this.child,
      this.onRefresh,
      this.onLoading,
      this.initWidget,
      this.loadingWhenInit = true,
      this.initPage = 1,
      this.isLast = false,
      this.refreshOnly = false})
      : super(key: key);

  @override
  RefreshLoadMoreWidgetState createState() => RefreshLoadMoreWidgetState();
}

class RefreshLoadMoreWidgetState extends State<RefreshLoadMoreWidget> {
  int _page = 1;
  bool isLast = false;
  var loading = false;
  var isLoadMore = false;
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    _page = widget.initPage;
    isLast = widget.isLast;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.loadingWhenInit) {
        setState(() {
          loading = true;
        });

      }
      widget.initWidget?.call();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RefreshLoadMoreWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void refreshCompleted() {
    _page = 1;
    setState(() {
      loading = true;
    });
  }

  void completeLoadingAndRefresh() {
    if (isLoadMore) {
      loadComplete();
    } else {
      refreshCompleted();
      _refreshController.refreshCompleted();
    }
  }

  void loadComplete([bool isSuccess = true]) {
    _refreshController.loadComplete();
    if (!isLast && isSuccess) _page++;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: widget.activeLoadMore,
      enablePullDown: true,
      onRefresh: () {
        if (widget.refreshOnly) {
          _refreshController.refreshCompleted();
        } else {
          setState(() {
            loading = true;
          });

          isLoadMore = false;
          _page = 1;

          if (widget.onRefresh != null) {
            widget.onRefresh!();
          }
        }
      },
      onLoading: () {
        isLoadMore = true;
        if (isLast) {
          _refreshController.loadComplete();
        } else {
          if (widget.onLoading != null) {
            final mPage = _page + 1;
            widget.onLoading!(mPage);
          }
        }
      },
      child: loading ? const LoadingWidget() : widget.child,
    );
  }
}
