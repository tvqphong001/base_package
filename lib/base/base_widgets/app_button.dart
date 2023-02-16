import 'package:auto_size_text/auto_size_text.dart';
import 'package:mpos/base/base.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final String titleButton;
  final Widget? child;
  final double? height;
  final double? titleButtonSize;
  final FontWeight? titleButtonFontWeight;
  final double? marginVerticalTitle;
  final double? marginHorizontalTitle;
  final Color? bgColor;
  final Color? shadowColor;
  final Color? titleColor;
  final Color? iconColor;
  final double? borderRadius;
  final Color? borderColor;
  final dynamic iconTitle;
  final double? width;
  final bool enable;

  const AppButton(
      {Key? key,
      required this.onPressed,
      this.titleButton = '',
      this.child,
      this.bgColor,
      this.height,
      this.shadowColor,
      this.iconTitle,
      this.iconColor,
      this.titleColor,
      this.width,
      this.borderRadius,
      this.borderColor,
      this.titleButtonSize,
      this.marginHorizontalTitle,
      this.titleButtonFontWeight,
      this.marginVerticalTitle,
      this.enable = true})
      : super(key: key);

  const AppButton.secondary(
      {Key? key,
      required this.onPressed,
      this.titleButton = '',
      this.child,
      this.height,
      this.bgColor = Colors.transparent,
      this.shadowColor,
      this.iconTitle,
      this.iconColor,
      this.titleColor = ColorsApp.cyan600,
      this.width,
      this.borderRadius,
      this.borderColor = ColorsApp.cyan600,
      this.titleButtonSize,
      this.marginHorizontalTitle,
      this.titleButtonFontWeight,
      this.marginVerticalTitle,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var enableBgColor = enable ? bgColor ?? ColorsApp.cyan600 : ColorsApp.wiserink40;
    var textColor = enable ? titleColor ?? Colors.white : ColorsApp.wiserink10;
    return Container(
      width: width,
      height: height ?? (isTabletOrWeb ? 56 : 48),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: shadowColor ?? Colors.transparent,
              blurRadius: 10.0,
              offset: const Offset(0, 6))
        ],
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
        border: enable
            ? Border.all(
                color: borderColor ?? ColorsApp.cyan600,
              )
            : null,
        color: enableBgColor,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(10, 10),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 5)),
        ),
        onPressed: () {
          onPressed();
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: marginVerticalTitle ?? 15, horizontal: marginHorizontalTitle ?? 0),
          child: child ??
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  iconTitle != null
                      ? AppImage(
                          iconTitle!,
                          color: iconColor??textColor,
                          size: 20,
                        )
                      : const SizedBox(),
                  SizedBox(width: iconTitle != null && titleButton.isNotEmpty ? 5 : 0),
                  AppText(
                    text: titleButton,
                    textSize: titleButtonSize ?? 16,
                    fontWeight: titleButtonFontWeight ?? FontWeight.w700,
                    color: textColor,
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
