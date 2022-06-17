import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/customswitch.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/locationsettings/models/locationsetting.dart';

class LocationSettings extends ConsumerWidget {
  const LocationSettings({required this.locationSetting, Key? key})
      : super(key: key);
  final LocationSetting locationSetting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 43.sh(), left: 73.sw()),
          child: SizedBox(
            width: 816.sw(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location Settings',
                  style: kTextStyleInterSemiBold.copyWith(
                      fontSize: 21.ssp(), color: primaryColor),
                ),
                SizedBox(
                  height: 43.sh(),
                ),
                CustomSwitch(
                  value: locationSetting.starvaFile,
                  text: "Allow Starva File Upload",
                  onChanged: (va) {},
                  space: 566.sw(),
                ),
                SizedBox(
                  height: 85.sw(),
                ),
                OutlineAndElevatedButton(
                  onApply: () {},
                ),
                // OutlineAndElevatedButton(
                //   width: 126.sw(),
                //     height: 46.sh(),
                //   space: 60.sw(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
