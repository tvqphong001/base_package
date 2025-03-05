import '../../base.dart';

var paddingAppScaffold = 20.0;
var paddingTopScrollAppScaffold = 0.0;

class AppScaffold extends StatelessWidget {
  final Widget body;
  final double? padding;
  final double? paddingHorizontal;
  final EdgeInsets? paddingOnly;
  final double? paddingVertical;
  final AppBar? appBar;
  final bool enableScrollContent;
  final double? paddingTopScroll;
  final Widget? bottomButton;
  final Widget? bottomContainer;
  final Widget? topContainer;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final bool paddingStatusBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Function(bool)? onDrawerChanged;
  final Function(bool)? onEndDrawerChanged;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool bottomSafeArea;
  final bool topSafeArea;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final ScrollController? scrollController;
  final EdgeInsets? paddingScroll;
  final double? paddingBottomScroll;

  const AppScaffold({
    super.key,
    required this.body,
    this.paddingHorizontal,
    this.appBar,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.enableScrollContent = false,
    this.paddingTopScroll,
    this.bottomButton,
    this.bottomContainer,
    this.topContainer,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.paddingVertical,
    this.padding,
    this.floatingActionButton,
    this.bottomSafeArea = false,
    this.scrollController,
    this.paddingStatusBar = true, this.drawer, this.onDrawerChanged, this.scaffoldKey, this.endDrawer, this.onEndDrawerChanged, this.paddingOnly, this.floatingActionButtonLocation, this.topSafeArea =false, this.paddingScroll, this.paddingBottomScroll,
  })  : assert(padding == null || (paddingHorizontal == null && paddingVertical == null)),
        assert(bottomContainer == null || bottomButton == null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: topSafeArea,
      bottom: bottomSafeArea,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            floatingActionButtonLocation: floatingActionButtonLocation,
            appBar: appBar,
            key: scaffoldKey,
            // extendBodyBehindAppBar: true,
            backgroundColor: backgroundColor,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: bottomNavigationBar,
            extendBody: extendBody,
            drawer: drawer,
            endDrawer: endDrawer,
            onDrawerChanged: onDrawerChanged,
            onEndDrawerChanged: onEndDrawerChanged,
            body: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: paddingOnly ??(padding == null
                    ? EdgeInsets.symmetric(horizontal: paddingHorizontal ?? paddingAppScaffold, vertical: paddingVertical ?? 0)
                    : EdgeInsets.all(padding ?? 16)),
                child: Column(
                  children: [
                    if(topContainer!= null) topContainer!,
                    // if (appBar == null)
                    //   SizedBox(
                    //     height: paddingStatusBar ? ScreenHelper.statusBar : 0,
                    //   ),
                    Expanded(
                      child: enableScrollContent
                          ? SingleChildScrollView(
                        controller: scrollController,
                              padding: paddingScroll??EdgeInsets.only(bottom: paddingBottomScroll??20,top: paddingTopScrollAppScaffold),
                              child: body,
                            )
                          : body,
                    ),
                    if(bottomContainer != null)bottomContainer!,
                    if (bottomButton != null && bottomContainer == null) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      bottomButton!,
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}


class AppScaffoldFixBugWithTabbarView extends StatelessWidget {
  final Widget? floatingActionButton;
  final Widget body;
  final Color? backgroundColor;

  const AppScaffoldFixBugWithTabbarView({super.key, this.floatingActionButton, required this.body, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: body,
          ),
          if (floatingActionButton != null)
            Positioned(
              right: 20,
              bottom: 50,
              child: floatingActionButton!,
            ),
        ],
      ),
    );
  }
}
