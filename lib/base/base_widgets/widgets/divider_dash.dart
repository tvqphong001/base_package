import '../../base.dart';

var colorDividerDash = Colors.black;

class DividerDash extends StatelessWidget {
  final double height;
  final Color? color;
  final double dashWidth;

  const DividerDash({Key? key, this.height = 1, this.color,this. dashWidth = 5})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color??colorDividerDash),
              ),
            );
          }),
        );
      },
    );
  }
}