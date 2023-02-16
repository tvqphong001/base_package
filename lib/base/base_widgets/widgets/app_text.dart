import '../../base.dart';

class TextApp extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final bool? softWrap;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextStyle? style;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap ?? true,
      // textScaleFactor: 1.0,
      style: style ??
          textTheme.bodyMedium?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            decoration: textDecoration,
            height: height,
          ),
    );
  }
}
