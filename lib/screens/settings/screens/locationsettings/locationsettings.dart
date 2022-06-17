import 'package:videomanager/screens/others/exporter.dart';
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
                  'Map Default Location',
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
            Row(children: [
              Container(
                width: 126.sw(),
                height: 46.sh(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.sr()),
                    border: Border.all(color: Colors.black)),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
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
                    // var settingService =
                    //     ref.read(settingChangeNotifierProvider);
                    // settingService.updateSetting(
                    //     mapSetting: mapSetting..defaultLocation.enabled = false);
                  },
                  child: Text(
                    'Apply',
                    style: kTextStyleIbmMedium.copyWith(
                        color: Colors.white, fontSize: 17.ssp()),
                  ),
                ),
              ),
            ])
          ],
         ),
          ),
      ),
    );
  }
}