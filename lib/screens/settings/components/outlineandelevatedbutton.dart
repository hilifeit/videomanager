import 'package:videomanager/screens/others/exporter.dart';

class OutlineAndElevatedButton extends StatelessWidget {
   OutlineAndElevatedButton({Key? key, required this.onApply,  this.text, this.center= false})
      : super(key: key);
  final Function onApply;
   String? text;
   bool center;
  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: center?MainAxisAlignment.center:MainAxisAlignment.start,

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
              'Reset',
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
          onPressed: () {
            onApply();
            // var settingService =
            //     ref.read(settingChangeNotifierProvider);
            // settingService.updateSetting(
            //     mapSetting: mapSetting..defaultLocation.enabled = false);
          },
          child: Text(
            text??'Apply',
            style: kTextStyleIbmMedium.copyWith(
                color: Colors.white, fontSize: 17.ssp()),
          ),
        ),
      ),
    ]);
  }
}
