import 'package:flutter/gestures.dart';

import '../../base.dart';

class AppCheckboxOnly extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;
  final BorderSide? side;
  final MaterialStateProperty<Color?>? fillColor;
  final double? height;
  final double? width;
  const AppCheckboxOnly({super.key,required this.value,required this.onChanged, this.side, this.fillColor,this.height = 24,this.width = 24,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xff6F61FF),
        fillColor: fillColor,
        side: side,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}


class AppCheckbox extends StatefulWidget {
  final bool defaultValue;
  final String? text;
  final Widget? widget;
  final ValueChanged<bool> onValueChange;

  const AppCheckbox({
    Key? key,
    this.defaultValue = false,
    this.text,
    this.widget,
    required this.onValueChange,
  }) : super(key: key);

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool isCheck;

  @override
  void initState() {
    isCheck = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(

          value: isCheck,
          onChanged: (value) {
            setState(() {
              isCheck = value ?? false;
            });
            widget.onValueChange(isCheck);
          },
          activeColor: const Color(0xff6F61FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        if(widget.widget != null) widget,
        if (widget.text != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 8,
                // ),
                RichText(
                  text: TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: [
                    TextSpan(
                        text: widget.text!,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isCheck = !isCheck;
                            });
                            widget.onValueChange(isCheck);
                          })
                  ],),
                ),
              ],
            ),
          )
      ],
    );
  }
}
