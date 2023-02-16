import 'package:flutter/gestures.dart';

import '../base.dart';

class AppCheckbox extends StatefulWidget {
  final bool defaultValue;
  final String? text;
  final ValueChanged<bool> onValueChange;

  const AppCheckbox({
    Key? key,
    this.defaultValue = false,
    this.text,
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
        if (widget.text != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                RichText(

                  text: TextSpan(style: textTheme.bodyMedium, children: [
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
