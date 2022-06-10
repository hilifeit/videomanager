import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  TextEditingController? textEditingController;
  String? hintText;
  double? hintFontSize;
  Icon? prefixIcon;
  Color? fillColor;
  String? errorText;
  bool? obsecureText;
  String? labelText;
  Function(String? input)? onChanged;

  AppTextField(
      {this.textEditingController,
      this.hintText,
      this.hintFontSize,
      this.prefixIcon,
      this.fillColor,
      this.errorText,
      this.labelText,
      this.obsecureText,
      this.onChanged});

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
        scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: textEditingController,
          onChanged: onChanged,
          obscureText: obsecureText ?? false ? true : false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
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
