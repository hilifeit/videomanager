import 'package:videomanager/screens/others/exporter.dart';

class AppButtonOutline extends StatelessWidget {
  final Function()? onPressedFunction;
  final String? text;
  final BuildContext context;
  final double? width;
  final double? height;

  const AppButtonOutline(
      {Key? key,
      required this.onPressedFunction,
      required this.text,
      required this.context,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Theme.of(context).primaryColor,
      splashColor: Theme.of(context).splashColor,
      textTheme: ButtonTextTheme.primary,
      height: height ?? 40,
      minWidth: width ?? 200,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
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
