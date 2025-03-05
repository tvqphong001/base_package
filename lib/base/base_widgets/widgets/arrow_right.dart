import '../../../base_package.dart';

class ArrowRight extends StatelessWidget {
  final Color? color;
  final double? size;
  const ArrowRight({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: color,
          size: size,
        ));
  }
}
