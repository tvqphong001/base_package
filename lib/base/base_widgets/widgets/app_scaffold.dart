import '../../base.dart';


class AppScaffold extends StatelessWidget {
  final Widget body;
  final double? padding;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final AppBar? appBar;
  final bool enableScrollContent;
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
  const AppScaffold({
    Key? key,
    required this.body,
    this.paddingHorizontal,
    this.appBar,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.enableScrollContent = false,
    this.bottomButton,
    this.bottomContainer,
    this.topContainer,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.paddingVertical,
    this.padding,
    this.floatingActionButton,
    this.paddingStatusBar = true, this.drawer, this.onDrawerChanged, this.scaffoldKey, this.endDrawer, this.onEndDrawerChanged,
  })  : assert(padding == null || (paddingHorizontal == null && paddingVertical == null)),
        assert(bottomContainer == null || bottomButton == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: appBar,
            key: scaffoldKey,
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
                padding: padding == null
                    ? EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 0, vertical: paddingVertical ?? 0)
                    : EdgeInsets.all(padding ?? 16),
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
                              padding: const EdgeInsets.only(bottom: 20),
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
                    ]
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
