import '../../base.dart';

class MyBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final double? size;
  const MyBackButton({Key? key, this.color, this.onPressed, this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: MaterialButton(
        // height: size,
        // minWidth: size,
        padding: EdgeInsets.zero,
        onPressed: () {
          if(onPressed != null){
            onPressed!();
          }else {
            Navigator.pop(context);
          }
        },
        child: Icon(
          Icons.arrow_back
        )
      ),
    );
  }
}
