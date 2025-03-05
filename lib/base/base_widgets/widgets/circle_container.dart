import '../../../base_package.dart';

class ContainerCircle extends StatelessWidget {
  final double size;
  final Widget? child;
  final Color? color;
  const ContainerCircle({super.key, required this.size, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: color??Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(size/2)
      ),
      child: child,
    );
  }
}
