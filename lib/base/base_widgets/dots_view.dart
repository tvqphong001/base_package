import 'package:mpos/base/base.dart';

class DotsWidget extends StatelessWidget {
  final int length;
  final int index;
  final double size;
  final Function(int)? onTapDot;
  final double horizontalPadding;
  final Color activeColor;
  final Color inactiveColor;
  const DotsWidget({
    Key? key,
    required this.length,
    required this.index,
    this.onTapDot,
    this.size = 6,
    this.horizontalPadding = 3,
    this.activeColor = const Color(0xff08C4E3),
    this.inactiveColor = const Color(0xffF0F3F8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    for (int i = 0; i < length; i++) {
      list.add(Container(
        height: size,
        width: size,
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            color: index == i ? activeColor : inactiveColor),
        child: Button.noAnim(child: const SizedBox(), onPressed: () {
          onTapDot?.call(i);
        },),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}
