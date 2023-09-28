import 'package:base_package/base/base.dart';

class TextFormFieldApp extends StatefulWidget {
  final String label;
  final bool isRequired;
  final String? hint;
  final TextEditingController controller;
  final Widget? suffix;
  final Widget? widgetOverlay;
  final EdgeInsets? paddingWidgetOverlay;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChange;
  final int? maxLength;

  const TextFormFieldApp(
      {Key? key,
        required this.label,
        this.isRequired = false,
        this.hint,
        required this.controller,
        this.suffix,
        this.onTap,
        this.validator,
        this.keyboardType,
        this.autofillHints,
        this.textInputAction,
        this.textCapitalization = TextCapitalization.none,
        this.widgetOverlay,
        this.inputFormatters,
        this.onChange,
        this.maxLength,
        this.paddingWidgetOverlay})
      : super(key: key);

  @override
  State<TextFormFieldApp> createState() => _TextFormFieldAppState();
}

class _TextFormFieldAppState extends State<TextFormFieldApp> {
  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Widget child;
    var content = TextFormField(
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      autofillHints: widget.autofillHints,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      style: TextStyle(
        fontSize: 16 / MediaQuery.of(context).textScaleFactor,
        color: widget.widgetOverlay != null ? Colors.white : Colors.black,
        fontWeight: FontWeight.w400,
      ),
      onChanged: widget.onChange,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        suffixIcon: widget.suffix,
        label: Row(
          children: <Widget>[
            TextApp(
              widget.label,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            if (widget.isRequired)
              const TextApp(
                ' *',
                color: Colors.red,
              ),
          ],
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1)),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    if (widget.onTap != null || widget.widgetOverlay != null) {
      child = Stack(
        children: [
          content,
          Positioned(
            top: widget.paddingWidgetOverlay?.top ?? 0,
            bottom: widget.paddingWidgetOverlay?.bottom ?? 0,
            right: widget.paddingWidgetOverlay?.right ?? 40,
            left: widget.paddingWidgetOverlay?.left ?? 0,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                color: Colors.transparent,
                child: widget.widgetOverlay,
              ),
            ),
          ),
        ],
      );
    } else {
      child = content;
    }

    return child;
  }
}