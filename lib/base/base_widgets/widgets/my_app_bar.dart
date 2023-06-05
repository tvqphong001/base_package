import '../../base.dart';

class MyAppBar extends _AppBar {
  MyAppBar({
    Key? key,
    BuildContext? context,
    String title = '',
    Widget? titleWidget,
    List<Widget>? actions,
    double? elevation,
    Color? backgroundColor,
    VoidCallback? onLeadingPressed,
  }) : super(
          key: key,
          title: title,
          onLeadingPressed: onLeadingPressed,
          titleWidget: titleWidget,
          backgroundColor: backgroundColor,
          elevation: elevation,
          actions: actions,
        );

  MyAppBar.normal({
    Key? key,
    String title = '',
    Widget? titleWidget,
    List<Widget>? actions,
    VoidCallback? onLeadingPressed,
    Color? backgroundColor,
    double? elevation,
    bool hideLeading = false,
    Color? leadingButtonColor,
  }) : super(
          key: key,
          title: title,
          backgroundColor: backgroundColor,
          onLeadingPressed: onLeadingPressed,
          titleWidget: titleWidget,
          elevation: elevation,
          actions: actions,
          hideLeading: hideLeading,
          leadingButtonColor: leadingButtonColor,
        );

  MyAppBar.appBarWithButton({
    Key? key,
    Color? leadingButtonColor,
    required String title,
    required BuildContext context,
    required Widget? imageButton,
  }) : super(
          key: key,
          title: title,
          actions: [
            imageButton!,
            const SizedBox(width: 5),
          ],
          leadingButtonColor: leadingButtonColor,
        );

  MyAppBar.gallery({
    Key? key,
    String title = 'Gallery',
    Widget? titleWidget,
    List<Widget>? actions,
    VoidCallback? onLeadingPressed,
    Color? leadingButtonColor,
  }) : super(
          key: key,
          title: title,
          onLeadingPressed: onLeadingPressed,
          titleWidget: titleWidget,
          actions: actions,
          leadingButtonColor: leadingButtonColor,
        );

  // Widget _appBar() {
  //   return SizedBox(
  //       height: ScreenHelper.portraitStatusBar + kToolbarHeight,
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: ScreenHelper.portraitStatusBar,
  //           ),
  //           Expanded(
  //             child: Row(
  //               children: [
  //                 const BackButton(),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 const TextWidget(
  //                   text: 'Gallery',
  //                   fontSize: 20,
  //                 ),
  //                 const Spacer(),
  //                 Obx(() {
  //                   return SelectButton(
  //                     onPressed: () {
  //                       controller.setSelectMode();
  //                     },
  //                     selectMode: controller.selectMode.value,
  //                   );
  //                 }),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
  //               ],
  //             ),
  //           ),
  //         ],
  //       ));
  // }
}

class _AppBar extends AppBar {
  _AppBar({
    Key? key,
    String title = '',
    Widget? titleWidget,
    List<Widget>? actions,
    VoidCallback? onLeadingPressed,
    Color? leadingButtonColor,
    bool hideLeading = false,
    double? elevation = 0,
    Color? backgroundColor,
  }) : super(
          key: key,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: backgroundColor ,
          title: titleWidget ??
              TextApp(
                title,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
          elevation: 0,
          centerTitle: true,
          leading: hideLeading
              ? null
              : MyBackButton(
                  onPressed: () {
                    if (onLeadingPressed == null) {
                      pop();
                    } else {
                      onLeadingPressed.call();
                    }
                  },
                  color: leadingButtonColor,
                ),
          actions: [
            ...?actions,
            if (actions != null && actions.isNotEmpty)
              const SizedBox(width: 10),
          ],
        );
}

class MyBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  const MyBackButton({Key? key, this.onPressed, this.color,this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: size,
        height: size,
        onPressed: () {
          if (onPressed == null) {
            pop();
          } else {
            onPressed?.call();
          }
        },
        child: Icon(
          Icons.arrow_back,
          color: color,
        ));
  }
}
