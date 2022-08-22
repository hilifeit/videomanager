import 'package:flutter/services.dart';
import 'package:videomanager/screens/others/exporter.dart';

const double minButtonHeight = 45;
const double buttonHeight = 55;

class CustomOutlinedButton extends StatelessWidget {
  CustomOutlinedButton({
    Key? key,
    this.onPressedOutlined,
    required this.outlinedButtonText,
    this.width,
    this.height,
    this.borderColor,
  }) : super(key: key);

  final Function? onPressedOutlined;
  final String outlinedButtonText;
  double? width, height;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressedOutlined == null ? false : true;
    return Container(
      width: width ?? 126.sw(),
      height: height ?? 46.sh(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.sr()),
          border: Border.all(color: borderColor ?? Colors.black)),
      child: Consumer(builder: (context, ref, c) {
        return TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(
                    (states) => EdgeInsets.zero)),
            onPressed: enabled
                ? () {
                    onPressedOutlined!();
                  }
                : null,
            child: Text(
              outlinedButtonText,
              style: kTextStyleIbmRegular.copyWith(
                color: borderColor ?? Colors.black,
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
    this.icon,
  }) : super(key: key);

  final Function? onPressedElevated;
  final String elevatedButtonText;
  double? width, height;
  TextStyle? elevatedButtonTextStyle;
  EdgeInsetsGeometry? elevatedButtonPadding;
  Color? color;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressedElevated == null ? false : true;

    return SizedBox(
      width: width ?? 126.sw(),
      height: height ?? 46.sh(),
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(
                (states) => elevatedButtonPadding ?? EdgeInsets.zero),
            backgroundColor: MaterialStateColor.resolveWith((states) =>
                enabled ? color ?? Theme.of(context).primaryColor : darkGrey)),
        onPressed: enabled
            ? () {
                onPressedElevated!();
              }
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
                size: 15.ssp(),
              ),
            Text(
              elevatedButtonText,
              style: elevatedButtonTextStyle ??
                  kTextStyleIbmRegular.copyWith(
                    color: Colors.white,
                    fontSize: 17.ssp(),
                  ),
            ),
          ],
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
  final String title;
  String? suffixText;
  Color? fillColor = Colors.transparent;
  bool isVisible = true;
  final String? Function(String? val)? validator;
  final Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  TextStyle? hintStyle, suffixStyle;
  final TextStyle? style;
  final String value;
  final Function(String) onChanged;
  bool isdigits;
  bool limit;
  int limitNumber;
  InputTextField(
      {Key? key,
      required this.title,
      this.value = '',
      this.hintStyle,
      this.validator,
      required this.isVisible,
      this.fillColor,
      this.prefixIcon,
      this.suffixIcon,
      this.style,
      this.onTap,
      this.isdigits = false,
      this.limit = false,
      this.limitNumber = 10,
      this.suffixText,
      this.suffixStyle,
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
              Text(
                title,
                style: kTextStyleIbmSemiBold.copyWith(
                  fontSize: 16.ssp(),
                ),
              ),
              SizedBox(
                height: 9.5.sh(),
              ),
            ],
          ),
        ),
        TextFormField(
          maxLines: title == 'Remarks' ? 3 : 1,
          controller: TextEditingController(text: value),
          inputFormatters: [
            if (limit) LengthLimitingTextInputFormatter(limitNumber),
            isdigits
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.singleLineFormatter
          ],
          style: style ??
              kTextStyleIbmMedium.copyWith(
                  color: Colors.black, fontSize: 16.ssp()),
          onTap: onTap,
          //controller: TextEditingController(text: ''),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (val) {
            onChanged(val);
          },

          decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 10.ssp(), color: danger),
            prefixIcon: prefixIcon,
            suffixText: suffixText,
            suffixIcon: suffixIcon,
            suffixStyle: suffixStyle,
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
            contentPadding: EdgeInsets.only(
              left: 17.sw(),
              top: 16.sh(),
              bottom: 16.sh(),
              right: 17.sw(),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sr()),
              borderSide: const BorderSide(color: darkGrey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sr()),
              borderSide: const BorderSide(color: darkGrey, width: 1),
            ),
            hintText: title == 'Remarks'
                ? 'Write remarks if any'
                : isVisible
                    ? 'Enter ${title.toLowerCase()}'
                    : title,
            hintStyle: hintStyle ??
                kTextStyleIbmRegular.copyWith(
                  fontSize: 16.ssp(),
                ),
          ),
        ),
      ],
    );
  }
}
