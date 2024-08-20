import '../../base.dart';

class MyBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final double? size;
  final dynamic icon;
  const MyBackButton({Key? key, this.color, this.onPressed, this.size = 40, this.icon}) : super(key: key);

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
        child: AppImage(
          icon??Icons.arrow_back,
          size: size != null ? size! - 5 : null,
          color: color,
        )
      ),
    );
  }
}
