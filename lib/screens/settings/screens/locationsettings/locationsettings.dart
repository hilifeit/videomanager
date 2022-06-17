import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/locationsettings/models/locationsetting.dart';

class LocationSettings extends ConsumerWidget {
  const LocationSettings({required this.locationSetting, Key? key}) : super(key: key);
  final LocationSetting locationSetting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          
         padding: EdgeInsets.only(top: 43.sh(), left: 73.sw()),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Allow Starva File Upload',
                  style: kTextStyleInterRegular.copyWith(
                      fontSize: 16.ssp(), color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 7.sw()),
                  child: Switch(
                      // activeColor: Theme.of(context).primaryColor,
                      value: locationSetting.starvaFile,
                      onChanged: (value) {}),
                )
              ],
            ),
            SizedBox(height: 85.sw(),),
            OutlineAndElevatedButton(),
            // OutlineAndElevatedButton(
            //   width: 126.sw(),
            //     height: 46.sh(),
            //   space: 60.sw(),
            // ),

          ],
         ),
          ),
      ),
    );
  }
}

