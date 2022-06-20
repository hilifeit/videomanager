// ignore: file_names
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final double? hintFontSize;
  final Icon? prefixIcon;
  final Color? fillColor;
  final String? errorText;
  final bool? obsecureText;
  final String? labelText;
  final Function(String? input)? onChanged;

  const AppTextField(
      {Key? key,
      this.textEditingController,
      this.hintText,
      this.hintFontSize,
      this.prefixIcon,
      this.fillColor,
      this.errorText,
      this.labelText,
      this.obsecureText,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText == null ? Container() : Text(labelText!),
        labelText == null
            ? Container()
            : const SizedBox(
                height: 4,
              ),
        TextFormField(
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: textEditingController,
          onChanged: onChanged,
          obscureText: obsecureText ?? false ? true : false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            prefixIcon: prefixIcon,
            hintStyle: TextStyle(
                fontSize: hintFontSize ?? 14,
                color: Theme.of(context).hintColor),
            fillColor:
                fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
            filled: true,
            hintText: hintText,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
