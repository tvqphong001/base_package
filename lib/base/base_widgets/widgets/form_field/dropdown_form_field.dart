import 'package:base_package/base/base.dart';

class DropdownButtonFormFieldApp<T> extends StatelessWidget {
  final String? label;
  final bool isRequired;
  final T? value;
  final Function(T value) onChange;
  final List<T> listData;
  final String Function(T value) displayText;
  final Color? borderColor;
  final String? hint;
  final FormFieldValidator<T>? validator;

  const DropdownButtonFormFieldApp({
    super.key,
    this.label,
    this.isRequired = false,
    required this.value,
    required this.onChange,
    required this.listData,
    required this.displayText,
    this.borderColor,
    this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<T>(
        validator: validator,
        decoration: InputDecoration(
          label: label != null
              ? Row(
                  children: <Widget>[
                    TextApp(
                      label!,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    if (isRequired)
                      const TextApp(
                        ' *',
                        color: Colors.red,
                      ),
                  ],
                )
              : null,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        value: value,
        hint: hint != null
            ? TextApp(
                hint!,
                color: Colors.black,
              )
            : null,
        items: listData
            .map((e) => DropdownMenuItem<T>(
                value: e,
                child: TextApp(
                  displayText(e),
                )))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            onChange.call(value);
          }
        },
      ),
    );
  }
}
