import '../../base.dart';

class MyBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const MyBackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      size: 50,
      onPressed: onPressed,
      child: const BackButtonIcon(),
    );
  }
}