

import '../../base.dart';

class WidgetTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final String? labelText;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? icon;
  final bool? expands;
  final TextInputAction? textInputAction;
  final InputBorder? focusedBorder;
  final double? cursorHeight;
  final Widget? suffixIcon;
  final bool? enabled;
  final TextAlignVertical? textAlignVertical;
  final TextStyle? hintStyle;
  final String? hintText;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final bool? autofocus;
  final FocusNode? focusNode;
  final InputBorder? focusedErrorBorder;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final GlobalKey<FormState>? keyTextFieldFrom;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String>? autofillHints;
  final String? counterText;
  final TextStyle? errorStyle;
  const WidgetTextFormField(
      {Key? key,
        required this.controller,
        this.autovalidateMode,
        this.validator,
        this.enabled,
        this.focusNode,
        this.border,
        this.hintText,
        this.icon,
        this.textInputAction,
        this.hintStyle,
        this.labelStyle,
        this.style,
        this.minLines,
        this.keyboardType,
        this.onChanged,
        this.contentPadding,
        this.labelText,
        this.obscureText,
        this.focusedBorder,
        this.cursorHeight,
        this.suffixIcon,
        this.enabledBorder,
        this.inputFormatters,
        this.maxLines,
        this.expands,
        this.textAlignVertical,
        this.autofocus,
        this.keyTextFieldFrom,
        this.onFieldSubmitted,
        this.autofillHints,
        this.maxLength,
        this.counterText,
        this.errorStyle,
        this.disabledBorder,
        this.errorBorder,
        this.focusedErrorBorder})
      : super(key: key);


  @override
  State<WidgetTextFormField> createState() => _WidgetTextFormFieldState();
}

class _WidgetTextFormFieldState extends State<WidgetTextFormField> {
  late TextEditingController _controller;
  var obscureText = false;

  @override
  void initState() {
    _controller = widget.controller??TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.keyTextFieldFrom,
      focusNode: widget.focusNode,
      controller: _controller,
      autofillHints: widget.autofillHints,
      textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
      cursorHeight: widget.cursorHeight,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus ?? false,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardAppearance: Brightness.light,
      enabled: widget.enabled ?? true,
      obscureText: widget.obscureText ?? false,
      expands: widget.expands ?? false,
      style: widget.style,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        icon: widget.icon,
        suffixIconConstraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
        contentPadding: widget.contentPadding,
        focusedBorder: widget.focusedBorder,
        counterText: widget.counterText,
        errorStyle: widget.errorStyle,
        focusedErrorBorder: widget.focusedErrorBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
        border: widget.border,
        disabledBorder: widget.disabledBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
        enabledBorder: widget.enabledBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
        errorBorder: widget.errorBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
        hintText: widget.hintText,
        labelStyle: widget.labelStyle,
        labelText: widget.labelText,
        suffixIcon: widget.suffixIcon,
        hintStyle: widget.hintStyle ,
      ),
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}

