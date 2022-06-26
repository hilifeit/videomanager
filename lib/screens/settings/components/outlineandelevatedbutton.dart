import 'package:videomanager/screens/components/customdialogbox/customdialogbox.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

class OutlineAndElevatedButton extends StatelessWidget {
  OutlineAndElevatedButton(
      {Key? key,
      required this.onApply,
      this.textSecond = '',
      this.text = 'Apply',
      this.center = false,
      required this.onSucess,
      required this.onReset,
      this.show = true,
      this.reset = false,
      this.edit = false,
      this.applyText = ''})
      : super(key: key);
  final Function onApply, onSucess, onReset;
  String text;
  bool center, reset;
  bool show;
  bool edit;
  String applyText, textSecond;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Container(
            width: show ? 126.sw() : 86.sw(),
            height: show ? 46.sh() : 31.sh(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.sr()),
                border: Border.all(color: Colors.black)),
            child: Consumer(builder: (context, ref, c) {
              return TextButton(
                  onPressed: () {
                    if (edit) ref.read(userChangeProvider).selectUser(null);
                    if (!show) {
                      Navigator.pop(context);
                    } else if (reset) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                                textSecond: 'reset the following settings?',
                                applyText: 'Yes',
                                reset: reset,
                                onApply: onApply,
                                onSucess: onSucess,
                                onReset: onReset);
                          });

                      // onReset();
                    }
                  },
                  child: Text(
                    center ? 'Cancel' : 'Reset',
                    style: kTextStyleIbmMedium.copyWith(
                      color: Colors.black,
                      fontSize: show ? 17.ssp() : 12.ssp(),
                    ),
                  ));
            }),
          ),
          SizedBox(
            width: show ? 60.sw() : 40.98.sw(),
          ),
          SizedBox(
            width: show ? 126.sw() : 86.sw(),
            height: show ? 46.sh() : 31.sh(),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).primaryColor)),
              onPressed: () async {
                bool? status = await onApply();
                status = status ?? true;

                if (reset && !show) {
                  print('reset');
                  onReset();
                  Navigator.pop(context);
                }

                if (status && show) {
                  showDialog(
                      context: (context),
                      builder: (context) {
                        return CustomDialogBox(
                            textSecond: textSecond,
                            onApply: onApply,
                            onSucess: onSucess,
                            onReset: () {});
                      });
                } else if (!status) {}
                if (status && !show && !reset) {
                  // onReset();
                  print('true');
                  Navigator.pop(context);
                  await onSucess();
                }
              },
              child: Text(
                text,
                style: kTextStyleIbmMedium.copyWith(
                  color: Colors.white,
                  fontSize: show ? 17.ssp() : 12.ssp(),
                ),
              ),
            ),
          ),
        ]);
  }
}
