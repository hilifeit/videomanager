import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videomanager/screens/others/constant.dart';

const double minButtonHeight = 45;
const double buttonHeight = 55;

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.onPressed,
    this.label,
    this.fontSize = 14.5,
    this.primary = true,
    this.kLabelTextStyle,
  }) : super(key: key);
  final Function? onPressed;
  final String? label;
  final double? fontSize;
  final bool? primary;
  final TextStyle? kLabelTextStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
        //constraints: BoxConstraints(minHeight: minButtonHeight),
        decoration: primary!
            ? BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    spreadRadius: 1,
                    blurRadius: 16,
                    color: Colors.white.withOpacity(0.25))
              ])
            : BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                )),
        width: double.infinity,
        height: buttonHeight.h,

        //.h,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) =>
                    primary!
                        ? const Color(0xff40667D)
                        : Theme.of(context).scaffoldBackgroundColor)),
            onPressed: onPressed != null
                ? () {
                    onPressed!();
                  }
                : () {},
            child: Text(
              label!,
              //textScaleFactor: textScaleFactor,

              style: kLabelTextStyle,

              //textScaleFactor: textScaleFactor,
            )));
  }
}

class InputTextField extends StatelessWidget {
  final String? title;
  Color? fillColor = Colors.transparent;
  bool isVisible = true;
  String? Function(String? val)? validator;
  Function()? onTap;
  final Icon? prefixIcon;
  final TextStyle? hintStyle;

  InputTextField(
      {Key? key,
      required this.title,
      this.hintStyle,
      this.validator,
      required this.isVisible,
      this.fillColor,
      this.prefixIcon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: isVisible,
          child: Column(
            children: [
              Text(title!, style: kTextStyleIbmSemiBold),
              SizedBox(
                height: 9.5.h,
              ),
            ],
          ),
        ),
        TextFormField(
          style: kTextStyleIbmMedium.copyWith(color: Colors.black),
          onTap: onTap,
          //controller: TextEditingController(text: ''),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (val) {},
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: true,
            contentPadding:
                EdgeInsets.only(left: 19.5.w, top: 16.h, bottom: 17.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
            ),
            hintText: isVisible ? 'Enter ${title!.toLowerCase()}' : '$title',
            hintStyle: hintStyle,
          ),
        ),
      ],
    );
  }
}
