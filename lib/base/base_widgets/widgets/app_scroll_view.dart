import '../../base.dart';

class AppScrollView extends StatelessWidget {
  final Widget child;
  const AppScrollView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShaderMask(
      child: SingleChildScrollView(
        padding: defaultShaderPadding,
        child: child,
      ),
    );
  }
}
