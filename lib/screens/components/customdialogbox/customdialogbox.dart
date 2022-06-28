import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';

class CustomDialogBox extends StatelessWidget {
  CustomDialogBox(
      {Key? key,
      required this.onApply,
      required this.onSucess,
      required this.onReset,
      this.textFirst = 'Are you sure you want to ',
      this.textSecond = '',
      this.applyText = 'Yes',
      this.reset})
      : super(key: key);
  final Function onApply, onSucess, onReset;
  final String textFirst, textSecond, applyText;
  bool? reset;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 148.sh(),
        width: 434.sw(),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 86.sw(),
            vertical: 27.sh(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                textFirst + textSecond,
                textAlign: TextAlign.center,
                style: kTextStyleInterRegular.copyWith(
                  fontSize: 16.ssp(),
                  color: Colors.black,
                ),
              ),
              Spacer(),
              OutlineAndElevatedButton(
                reset: reset ?? false,
                text: applyText,
                show: false,
                center: true,
                onApply: onApply,
                onSucess: onSucess,
                onReset: onReset,
              )
            ],
          ),
        ),
      ),
    );
  }
}
