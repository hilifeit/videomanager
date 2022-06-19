import 'package:videomanager/screens/others/exporter.dart';

class OutlineAndElevatedButton extends StatelessWidget {
  OutlineAndElevatedButton({
    Key? key,
    required this.onApply,
    this.text,
    this.center = false,
    required this.onSucess,
  }) : super(key: key);
  final Function onApply, onSucess;
  String? text;
  bool center;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Container(
            width: 126.sw(),
            height: 46.sh(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.sr()),
                border: Border.all(color: Colors.black)),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  center ? 'Cancel' : 'Reset',
                  style: kTextStyleIbmMedium.copyWith(
                      color: Colors.black, fontSize: 17.ssp()),
                )),
          ),
          SizedBox(
            width: 60.sw(),
          ),
          SizedBox(
            width: 126.sw(),
            height: 46.sh(),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).primaryColor)),
              onPressed: () async {
                bool? status = await onApply();
                status = status ?? true;
                if (status) {
                  showDialog(
                      context: (context),
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Apply changes'),
                          content:
                              const Text('Do you want to apply the changes?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Cancel',
                                  style: kTextStyleInterSemiBold.copyWith(
                                      fontSize: 20.ssp(),
                                      color: Theme.of(context).primaryColor),
                                )),
                            TextButton(
                                onPressed: () async {
                                  await onSucess();
                                  Navigator.pop(context, onApply());
                                },
                                child: Text(
                                  'Confirm',
                                  style: kTextStyleInterSemiBold.copyWith(
                                      fontSize: 20.ssp(),
                                      color: Theme.of(context).primaryColor),
                                )),
                          ],
                        );
                      });
                }

                // var settingService =
                //     ref.read(settingChangeNotifierProvider);
                // settingService.updateSetting(
                //     mapSetting: mapSetting..defaultLocation.enabled = false);
              },
              child: Text(
                text ?? 'Apply',
                style: kTextStyleIbmMedium.copyWith(
                    color: Colors.white, fontSize: 17.ssp()),
              ),
            ),
          ),
        ]);
  }
}
