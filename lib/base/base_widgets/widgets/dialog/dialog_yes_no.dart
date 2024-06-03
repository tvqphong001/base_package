import 'package:base_package/base/base.dart';

typedef FutureCallBackCallback = Future<void> Function();

Future<bool?> showDialogYesNo({
  required String title,
  required BuildContext context,
  Function(BuildContext)? onBuilder,
  VoidCallback? onTap,
  VoidCallback? onTapCancel,
  FutureCallBackCallback? onTapFuture,
  FutureCallBackCallback? onTapCancelFuture,
  Widget Function(BuildContext context)? okButtonBuilder,
  Widget Function(BuildContext context)? cancelButtonBuilder,
  String? description,
  String? okText,
  String? cancelText,
  Widget? icon,
  double? insetHorizonPadding,
  bool? showCloseButton,
}) async {
  return await showDialog<bool?>(
    context: context,
    useSafeArea: true,
    builder: (context) {
      onBuilder?.call(context);
      return AlertPopup(
        onTap: onTap,
        onTapFuture: onTapFuture,
        onTapCancelFuture: onTapCancelFuture,
        onTapCancel: onTapCancel,
        okButtonBuilder: okButtonBuilder,
        cancelButtonBuilder: cancelButtonBuilder,
        title: title,
        description: description,
        okText: okText,
        cancelText: cancelText,
        icon: icon,
        insetHorizonPadding: insetHorizonPadding,
        showCloseButton: showCloseButton,
      );
    },
  );
}

class AlertPopup extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTapCancel;
  final FutureCallBackCallback? onTapFuture;
  final FutureCallBackCallback? onTapCancelFuture;
  final String? description;
  final String title;
  final String? okText;
  final String? cancelText;
  final Widget? icon;
  final double? insetHorizonPadding;
  final Widget Function(BuildContext context)? okButtonBuilder;
  final Widget Function(BuildContext context)? cancelButtonBuilder;
  final bool? showCloseButton;

  const AlertPopup(
      {super.key,
      required this.onTap,
      required this.onTapCancel,
      this.description,
      required this.title,
      this.okText,
      this.cancelText,
      this.onTapFuture,
      this.onTapCancelFuture,
      this.icon,
      this.okButtonBuilder,
      this.cancelButtonBuilder,
      this.insetHorizonPadding, this.showCloseButton,})
      : assert((onTap == null && onTapFuture == null) ||
            (onTapCancel == null || onTapCancelFuture == null));

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: insetHorizonPadding??30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(showCloseButton == false)  const SizedBox(height: 10,) else Row(
            children: [
              const Spacer(),
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Button(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    minWidth: 48,
                    height: 40,
                    child: const Icon(
                      Icons.close,
                      // color: ColorsApp.black,
                    ),
                  ))
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 24,
            ),
            child: Column(
              children: [

                if (icon != null) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  icon!,
                  const SizedBox(
                    height: 10,
                  )
                ],
                TextApp(
                  title,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  textAlign: TextAlign.center,
                ),
                if (description != null) ...[
                  const SizedBox(
                    height: 13,
                  ),
                  TextApp(
                    description!,
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: cancelButtonBuilder != null
                          ? cancelButtonBuilder!(context)
                          : Button(
                        onPressed: () {
                          if (onTapCancel == null) {
                            Navigator.pop(context, false);
                          } else {
                            onTapCancel?.call();
                          }
                        },
                        child: TextApp(cancelText ?? 'Cancel'),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: okButtonBuilder != null
                          ? okButtonBuilder!(context)
                          : Button(
                        onPressed: () async {
                          if (onTapFuture != null) {
                            await onTapFuture!();
                            Navigator.pop(context, true);
                          } else if (onTap == null) {
                            Navigator.pop(context, true);
                          } else {
                            onTap?.call();
                          }
                        },
                        child: TextApp(okText ?? 'OK'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
