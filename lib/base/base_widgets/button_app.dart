import '../base.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      this.onPressed,
      this.onLongPress,
      this.noAnim = false,
      required this.child,
      this.minWidth = 10,
      this.height,
      this.textToolTip,
      this.padding,
      this.background,
      this.borderRadius,
      this.border,
      this.boxShadow,
      this.maxWidth,
      this.hoverColor,
      this.margin,
      this.decoration, this.size})
      : super(key: key);

  const Button.noAnim(
      {Key? key,
      this.onPressed,
      this.onLongPress,
      this.noAnim = true,
      required this.child,
      this.minWidth = 10,
      this.height,
      this.textToolTip,
      this.padding,
      this.background,
      this.borderRadius,
      this.border,
      this.boxShadow,
      this.maxWidth,
      this.hoverColor,
      this.margin,
      this.decoration, this.size})
      : super(key: key);

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool noAnim;
  final Widget child;
  final double minWidth;
  final double? maxWidth;
  final double? height;
  final double? size;
  final Color? background;
  final Color? hoverColor;
  final String? textToolTip;
  final BorderRadius? borderRadius;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    var buttonBorderRadius =
        decoration != null ? decoration!.borderRadius! : borderRadius ?? BorderRadius.zero;
    return Container(
      height: size??height,
      margin: margin,
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: size??maxWidth ?? double.infinity,
      ),
      decoration: decoration ??
          BoxDecoration(
            color: background,
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            border: border,
          ),
      child: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        hoverColor: hoverColor,
        shape: RoundedRectangleBorder(
          borderRadius: buttonBorderRadius,
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        onLongPress: () {
          if (onLongPress != null) {
            onLongPress!();
          }
        },
        padding: padding ?? EdgeInsets.zero,
        splashColor: noAnim ? Colors.transparent : null,
        highlightColor: noAnim ? Colors.transparent : null,
        child: textToolTip != null
            ? Tooltip(
                message: textToolTip!,
                child: child,
              )
            : child,
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
