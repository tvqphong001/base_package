import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../base.dart';


class MyRefreshConfiguration extends StatelessWidget {
  final Widget child;
  final Widget header;
  final Widget footer;
  const MyRefreshConfiguration({super.key, required this.child, required this.header});

  @override
  Widget build(BuildContext context) {
    LoadingWidget
    // Smart Refresher under the global configuration subtree, here are a few particularly important attributes
    return RefreshConfiguration(
        headerBuilder: () => header
        /*ClassicHeader(
              idleText: Language.idleText.tr,
              releaseText: Language.releaseText.tr,
              refreshingText: Language.refreshingText.tr,
              completeText: Language.completeText.tr,
            )*/, // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
        footerBuilder: () => CustomFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              builder: (context, mode) {
                if (mode == LoadStatus.loading) {
                  return SizedBox(
                    height: 60.0,
                    child: Center(
                      child: Image.asset(
                        Images.loading,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ), // Configure default bottom indicator
        headerTriggerDistance: 80.0, // header trigger refresh trigger distance
        springDescription: const SpringDescription(
            stiffness: 170, damping: 16, mass: 1.9), // custom spring back animate,the props meaning see the flutter api
        maxOverScrollExtent:
            100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
        maxUnderScrollExtent: 0, // Maximum dragging range at the bottom
        enableScrollWhenRefreshCompleted:
            true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
        enableLoadingWhenFailed:
            true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
        hideFooterWhenNotFull:
            false, // Disable pull-up to load more functionality when Viewport is less than one screen
        enableBallisticLoad: true, // trigger load more by BallisticScrollActivity
        child: child);
  }
}
