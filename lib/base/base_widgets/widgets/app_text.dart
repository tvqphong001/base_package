import '../../base.dart';
import 'dart:ui' as ui;

String defaultText = '';
class TextApp extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final double? decorationThickness;
  final bool? softWrap;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final List<ui.Shadow>? shadows;
  final Color? color;
  final TextStyle? style;
  final String? fontFamily;
  final double? letterSpacing;

  const TextApp(
      this.text, {
        Key? key,
        this.fontSize,
        this.color,
        this.fontWeight,
        this.textAlign,
        this.maxLines,
        this.textOverflow,
        this.height,
        this.textDecoration,
        this.softWrap,
        this.fontStyle,
        this.style,
        this.fontFamily,
        this.letterSpacing,
        this.decorationColor,
        this.decorationThickness,
        this.shadows,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??defaultText,
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap ?? true,
      // textScaleFactor: 1.0,
      style: style ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            shadows: shadows,
            fontStyle: fontStyle,
            decoration: textDecoration,
            decorationColor: decorationColor,
            decorationThickness : decorationThickness,
            fontFamily: fontFamily,
            letterSpacing: letterSpacing,
            height: height,
          ),
    );
  }
}
