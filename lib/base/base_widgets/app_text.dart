import 'package:mpos/base/base.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final bool? softWrap;
  final double? height;
  final TextStyle? style;
  const AppText(
      {Key? key,
      required this.text,
      this.textSize,
      this.color,
      this.fontWeight,
      this.textAlign,
      this.maxLines,
      this.textOverflow,
      this.height,
      this.textDecoration,
      this.softWrap,
      this.fontStyle, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap ?? true,
      textScaleFactor: 1.0,
      style: style??textTheme.bodyMedium?.copyWith(
        fontSize: textSize??14,
        fontWeight: fontWeight,
        color: color,
        decoration: textDecoration,
        height: height,
      ),
    );
  }
}
