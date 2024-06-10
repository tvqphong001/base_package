import 'package:base_package/base/base.dart';

// text button default remove padding
class TextButtonApp extends TextButton {
  TextButtonApp({
    super.key,
    super.onPressed,
    required super.child,
    ButtonStyle? style,
  }) : super(
          style: style ??
              TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
        );
}
