

import '../../../base.dart';

enum AppTextFieldType {
  normal,
  selectable,
  onlyTap,
}

class SelectableData<T> {
  final T? value;
  final String text;
  final bool enable;

  SelectableData({this.enable = true, required this.value, required this.text});
}

class AppTextField<T> extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hint;
  final List<SelectableData<T>>? item;
  final AppTextFieldType type;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Color? hintColor;
  final FontStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final int? maxLine;
  final InputBorder? inputBorder;
  final TextStyle? textStyle;
  final String? initText;

  const AppTextField({
    Key? key,
    this.height,
    this.width,
    this.controller,
    this.borderRadius,
    this.suffixIcon,
    this.hint,
    this.hintStyle,
    this.item,
    this.onTap,
    this.type = AppTextFieldType.normal,
    this.keyboardType,
    this.borderColor,
    this.contentPadding,
    this.hintColor,
    this.maxLine,
    this.inputBorder,
    this.prefixIcon,
    this.textStyle, this.initText, this.onChange,
    this.backgroundColor,
  }) : super(key: key);

  const AppTextField.selectable({
    Key? key,
    this.height,
    this.width,
    this.controller,
    this.borderRadius,
    this.suffixIcon,
    this.hintStyle,
    this.hint,
    this.item,
    this.borderColor,
    this.contentPadding,
    this.hintColor,
    this.maxLine,
    this.inputBorder,
    this.prefixIcon,
    this.textStyle, this.initText, this.onChange,
    this.backgroundColor,
  })  : onTap = null,
        type = AppTextFieldType.selectable,
        keyboardType = null,
        super(key: key);

  const AppTextField.tapOnly({
    Key? key,
    this.height,
    this.width,
    this.controller,
    required this.onTap,
    this.suffixIcon,
    this.borderRadius,
    this.hint,
    this.borderColor,
    this.contentPadding,
    this.hintStyle,
    this.hintColor,
    this.maxLine,
    this.inputBorder,
    this.prefixIcon,
    this.textStyle, this.initText, this.onChange,
    this.backgroundColor,
  })  : item = null,
        type = AppTextFieldType.onlyTap,
        keyboardType = null,
        super(key: key);

  @override
  State<AppTextField> createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  var _enable = true;
  late TextEditingController _controller;

  @override
  void initState() {
    if (widget.type == AppTextFieldType.onlyTap) {
      _enable = false;
    }
    _controller = widget.controller??TextEditingController();
    _controller.text = widget.initText??'';
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: TextFormField(
        controller: _controller,
        enabled: _enable,
        maxLines: widget.maxLine,
        keyboardType: widget.keyboardType,
        style: widget.textStyle??Theme.of(context).textTheme.bodyMedium,
        onChanged: (value){
          widget.onChange?.call(value);
        },
        decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            contentPadding: widget.contentPadding,
            hintText: widget.hint,
            hintStyle: widget.textStyle == null
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: widget.hintColor,fontStyle: widget.hintStyle)
                : widget.textStyle?.copyWith(color: widget.hintColor,fontStyle: widget.hintStyle),
            border: widget.inputBorder ??
                OutlineInputBorder(
                    borderRadius: widget.borderRadius??BorderRadius.circular(4),
                    borderSide: BorderSide(width: 1, color: widget.borderColor ?? Colors.black)),
            disabledBorder: OutlineInputBorder(
                borderRadius: widget.borderRadius??BorderRadius.circular(4),
                borderSide: BorderSide(width: 1, color: widget.borderColor ?? Colors.black)),
            enabledBorder: OutlineInputBorder(
                borderRadius: widget.borderRadius??BorderRadius.circular(4),
                borderSide: BorderSide(width: 1, color: widget.borderColor ?? Colors.black))),
        onTap: widget.onTap,
      ),
    );
  }
}
