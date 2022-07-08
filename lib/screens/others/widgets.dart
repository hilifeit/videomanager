import 'package:flutter/services.dart';
import 'package:videomanager/screens/others/exporter.dart';

const double minButtonHeight = 45;
const double buttonHeight = 55;

class CustomOutlinedButton extends StatelessWidget {
  CustomOutlinedButton({
    Key? key,
    required this.onPressedOutlined,
    required this.outlinedButtonText,
    this.width,
    this.height,
  }) : super(key: key);

  final Function onPressedOutlined;
  final String outlinedButtonText;
  double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 126.sw(),
      height: height ?? 46.sh(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.sr()),
          border: Border.all(color: Colors.black)),
      child: Consumer(builder: (context, ref, c) {
        return TextButton(
            onPressed: () {
              onPressedOutlined();
            },
            child: Text(
              outlinedButtonText,
              style: kTextStyleIbmRegular.copyWith(
                color: Colors.black,
                fontSize: 17.ssp(),
              ),
            ));
      }),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    required this.onPressedElevated,
    required this.elevatedButtonText,
    this.width,
    this.height,
    this.elevatedButtonTextStyle,
    this.elevatedButtonPadding,
    this.color,
  }) : super(key: key);

  final Function onPressedElevated;
  final String elevatedButtonText;
  double? width, height;
  TextStyle? elevatedButtonTextStyle;
  EdgeInsetsGeometry? elevatedButtonPadding;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 126.sw(),
      height: height ?? 46.sh(),
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(
                (states) => elevatedButtonPadding ?? EdgeInsets.zero),
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => color ?? Theme.of(context).primaryColor)),
        onPressed: () {
          onPressedElevated();
        },
        child: Text(
          elevatedButtonText,
          style: elevatedButtonTextStyle ??
              kTextStyleIbmRegular.copyWith(
                color: Colors.white,
                fontSize: 17.ssp(),
              ),
        ),
      ),
    );
  }
}

class OutlinedElevatedButtonCombo extends StatelessWidget {
  OutlinedElevatedButtonCombo({
    Key? key,
    required this.outlinedButtonText,
    required this.elevatedButtonText,
    required this.onPressedOutlined,
    required this.onPressedElevated,
    this.width,
    this.height,
    this.spacing,
    this.elevatedButtonStyle,
    this.center = false,
  }) : super(key: key);

  final String outlinedButtonText, elevatedButtonText;
  final Function onPressedOutlined, onPressedElevated;
  double? width, height, spacing;
  TextStyle? elevatedButtonStyle;
  bool center;
  double defaultHeight = 46.sh();
  double defaultWidth = 126.sh();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        CustomOutlinedButton(
          width: width ?? defaultWidth,
          //96.sw(),
          height: height ?? defaultHeight,
          // 32.sh(),
          outlinedButtonText: outlinedButtonText,
          onPressedOutlined: () {
            onPressedOutlined();
          },
        ),
        SizedBox(
          width: spacing ?? 60.sw(),
        ),
        CustomElevatedButton(
          width: width ?? defaultWidth,
          // 96.sw(),
          height: height ?? defaultHeight,
          // 32.sh(),
          onPressedElevated: () {
            onPressedElevated();
          },
          elevatedButtonText: elevatedButtonText,
          elevatedButtonTextStyle: elevatedButtonStyle ??
              kTextStyleIbmRegular.copyWith(
                fontSize: 17.ssp(),
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  Button({
    Key? key,
    required this.onPressed,
    required this.label,
    this.primary = true,
    this.kLabelTextStyle,
    this.color,
    this.width,
  }) : super(key: key);
  double? width;
  final Function onPressed;
  final String label;

  final bool primary;
  TextStyle? kLabelTextStyle;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
        //constraints: BoxConstraints(minHeight: minButtonHeight),
        decoration: primary
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
        width: width ?? double.infinity,
        height: buttonHeight.h,

        //.h,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => primary ? const Color(0xff40667D) : color!)),
            onPressed: onPressed != null
                ? () {
                    onPressed();
                  }
                : () {},
            child: Text(
              label,
              //textScaleFactor: textScaleFactor,

              style: kLabelTextStyle ??
                  kTextStyleIbmRegular.copyWith(
                      fontSize: 17.ssp(), color: Colors.white),

              //textScaleFactor: textScaleFactor,
            )));
  }
}

class InputTextField extends StatelessWidget {
  final String? title;
  Color? fillColor = Colors.transparent;
  bool isVisible = true;
  final String? Function(String? val)? validator;
  final Function()? onTap;
  final Icon? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String value;
  final Function(String) onChanged;
  bool isdigits;
  InputTextField(
      {Key? key,
      required this.title,
      this.value = '',
      this.hintStyle,
      this.validator,
      required this.isVisible,
      this.fillColor,
      this.prefixIcon,
      this.style,
      this.onTap,
      this.isdigits = false,
      required this.onChanged})
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
                height: 9.5.sh(),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: TextEditingController(text: value),
          inputFormatters: [
            if (isdigits) LengthLimitingTextInputFormatter(10),
            isdigits
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.singleLineFormatter
          ],
          style: style ?? kTextStyleIbmMedium.copyWith(color: Colors.black),
          onTap: onTap,
          //controller: TextEditingController(text: ''),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (val) {
            onChanged(val);
          },
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: true,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sr()),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sr()),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding:
                EdgeInsets.only(left: 19.5.sw(), top: 16.sh(), bottom: 17.sh()),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sr()),
              borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sr()),
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
