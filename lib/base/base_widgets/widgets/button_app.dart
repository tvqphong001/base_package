import 'dart:async';

import '../../base.dart';

class Button extends StatefulWidget {
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
  final bool needDelay;

  const Button(
      {Key? key,
      required this.child,
      this.onPressed,
      this.onLongPress,
      this.noAnim = false,
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
      this.decoration,
      this.size,
      this.needDelay = true})
      : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Timer? timer;
  bool isEnable = true;

  @override
  Widget build(BuildContext context) {
    var buttonBorderRadius = widget.decoration != null
        ? widget.decoration!.borderRadius!
        : widget.borderRadius ?? BorderRadius.zero;
    return Container(
      height: widget.size ?? widget.height,
      margin: widget.margin,
      constraints: BoxConstraints(
        minWidth: widget.minWidth,
        maxWidth: widget.size ?? widget.maxWidth ?? double.infinity,
      ),
      decoration: widget.decoration ??
          BoxDecoration(
            color: widget.background,
            borderRadius: widget.borderRadius,
            boxShadow: widget.boxShadow,
            border: widget.border,
          ),
      child: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        hoverColor: widget.hoverColor,
        onPressed: () {
          if (widget.needDelay) {
            if (isEnable) {
              widget.onPressed?.call();
              isEnable = false;
              timer = Timer(const Duration(milliseconds: 500), () {
                isEnable = true;
              });
            }
          } else {
            widget.onPressed?.call();
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: buttonBorderRadius,
        ),
        onLongPress: () {
          if (widget.onLongPress != null) {
            widget.onLongPress!();
          }
        },
        padding: widget.padding ?? EdgeInsets.zero,
        splashColor: widget.noAnim ? Colors.transparent : null,
        highlightColor: widget.noAnim ? Colors.transparent : null,
        child: widget.textToolTip != null
            ? Tooltip(
                message: widget.textToolTip!,
                child: widget.child,
              )
            : widget.child,
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
