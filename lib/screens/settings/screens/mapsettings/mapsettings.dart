import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/customswitch.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting_model.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';

class MapSettings extends ConsumerWidget {
  MapSettings({Key? key, required this.mapSetting}) : super(key: key);
  final MapSetting mapSetting;

  late MapSetting temp = MapSetting.fromJson(mapSetting.toJson());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 43.sh(), left: 73.sw()),
        child: SizedBox(
          width: 816.sw(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Map Settings',
              style: kTextStyleInterSemiBold.copyWith(
                  fontSize: 21.ssp(), color: primaryColor),
            ),
            SizedBox(
              height: 43.sh(),
            ),
            CustomSlider(
              text: 'Zoom Factor',
              max: 10,
              min: 0,
              onChanged: (val) {
                temp.zoom = val;
              },
              value: mapSetting.zoom,
            ),
            SizedBox(
              height: 23.sh(),
            ),
            TextWithDDownButton<int>(
              values: List.generate(10, (index) => index),
              text: 'Stroke Width',
              value: mapSetting.stroke,
              helperText: "px",
              onChanged: (val) {
                temp.stroke = val;
              },
            ),
            SizedBox(
              height: 23.sh(),
            ),
            TextWithDDownButton<int>(
              values: List.generate(11, (index) => index * 10),
              text: 'Scroll Zoom in',
              value: mapSetting.scroll,
              helperText: "%",
              onChanged: (val) {temp.scroll = val;},
            ),
            SizedBox(
              height: 42.sh(),
            ),
            Text(
              'Sample Quality',
              style: kTextStyleInterRegular.copyWith(fontSize: 22.ssp()),
            ),
            SizedBox(
              height: 18.sh(),
            ),
            CustomSlider(
              text: 'Original Map Quality',
              min: 0,
              max: 720,
              onChanged: (val) {temp.sample.original = val.toInt();},
              value: mapSetting.sample.original.toDouble(),
            ),
            SizedBox(
              height: 33.sh(),
            ),
            CustomSlider(
                text: 'View Map Quality',
                max: 720,
                min: 0,
                onChanged: (val) {temp.sample.view = val.toInt();},
                value: mapSetting.sample.view.toDouble()),
            SizedBox(
              height: 33.sh(),
            ),
            CustomSlider(
              text: 'Original Mini Map Quality',
              max: 120,
              min: 0,
              onChanged: (val) {temp.sample.miniMap = val.toInt();},
              value: mapSetting.sample.miniMap.toDouble(),
            ),
            SizedBox(
              height: 56.sh(),
            ),
            CustomSwitch(
              text: 'Map Default Location',
              space: 0.sw(),
              value: mapSetting.defaultLocation.enabled,
              onChanged: (val) {temp.defaultLocation.enabled = val;},
            ),
            SizedBox(
              height: 22.sh(),
            ),
            if (mapSetting.defaultLocation.enabled) ...[
              Container(
                width: 816.sw(),
                height: 49.sh(),
                decoration: BoxDecoration(
                    color: lightWhite.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(4.sr())),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 32.sw(),
                    top: 14.sh(),
                    bottom: 14.sh(),
                  ),
                  child: Row(
                    children: [
                      VideoDetailText(
                        title: 'Latitude',
                        details: mapSetting.defaultLocation.lat.toString(),
                      ),
                      SizedBox(width: 11.sw()),
                      VideoDetailText(
                        title: 'Longitutde',
                        details: mapSetting.defaultLocation.lng.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 23.sh(),
              ),
            ],
            CustomSlider(
              text: 'Suggestion / Result Count',
              max: 10,
              min: 0,
              value: mapSetting.filterCount.toDouble(),
              onChanged: (val) {temp.filterCount = val.toInt();},
            ),
            SizedBox(
              height: 23.sh(),
            ),
            SizedBox(
              height: 96.sh(),
            ),
            OutlineAndElevatedButton(
              onApply: () {
                var setting = ref.read(settingChangeNotifierProvider);

                setting.updateSetting(mapSetting: temp);
              },
            ),
            SizedBox(height: 120.sh()),
          ]),
        ),
      ),
    ));
  }
}
