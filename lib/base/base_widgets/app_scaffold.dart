import 'package:flutter/services.dart';
import 'package:mpos/base/base.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final double? padding;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final AppBar? appBar;
  final bool enableScrollContent;
  final Widget? bottomButton;
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
  const MyScaffold({
    Key? key,
    required this.body,
    this.paddingHorizontal,
    this.appBar,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.enableScrollContent = false,
    this.bottomButton,
    this.bottomNavigationBar,
    this.backgroundColor = ColorsApp.wiserink20,
    this.paddingVertical,
    this.padding,
    this.floatingActionButton,
    this.paddingStatusBar = true, this.drawer, this.onDrawerChanged, this.scaffoldKey, this.endDrawer, this.onEndDrawerChanged,
  })  : assert(padding == null || (paddingHorizontal == null && paddingVertical == null)),
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
                    : EdgeInsets.all(padding ?? paddingApp),
                child: Column(
                  children: [
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
                    if (bottomButton != null) ...[
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
