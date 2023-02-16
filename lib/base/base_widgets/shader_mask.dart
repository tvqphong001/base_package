import '../base.dart';

const defaultShaderPadding = EdgeInsets.only(bottom: 40);
class AppShaderMask extends StatelessWidget {
  final BlendMode? blendMode;
  final List<Color>? colors;
  final ShaderCallback? shaderCallback;
  final Widget child;
  final bool isDrawShaderMask;
  final double? height;
  const AppShaderMask({
    Key? key,
    this.blendMode,
    this.colors,
    this.shaderCallback,
    this.isDrawShaderMask = true,
    this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: blendMode ?? BlendMode.dstOut,
      shaderCallback: shaderCallback ??
          (rect) {
            var _height = height;
            if (_height is double) {
              rect = Rect.fromLTWH(
                rect.left,
                rect.top + _height,
                rect.width,
                rect.height,
              );
            }
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors ??
                  <Color>[
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    if (isDrawShaderMask) ...[
                      const Color(0x50000000),
                      const Color(0xFF000000),
                    ],
                  ],
            ).createShader(rect);
          },
      child: child,
    );
  }
}
