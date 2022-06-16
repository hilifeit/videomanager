import 'package:flutter/material.dart';

class AppButtonOutline extends StatelessWidget {
  void Function()? onPressedFunction;
  String? text;
  BuildContext context;
  double? width;
  double? height;

  AppButtonOutline(
      {required this.onPressedFunction,
      required this.text,
      required this.context,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Theme.of(context).primaryColor,
      splashColor: Theme.of(context).splashColor,
      textTheme: ButtonTextTheme.primary,
      height: height??40,
      minWidth: width??200,

      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side :BorderSide(width: 1, color: Theme.of(context).primaryColor),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0))
        ),

        onPressed: onPressedFunction ?? () {},
        child: Text(
          text ?? "does something",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
