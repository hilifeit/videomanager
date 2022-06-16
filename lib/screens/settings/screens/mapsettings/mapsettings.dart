import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting_model.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

import 'package:videomanager/screens/video/components/videodetails.dart';

class MapSettings extends ConsumerWidget {
  MapSettings({Key? key, required this.mapSetting}) : super(key: key);
  final MapSetting mapSetting;
  late MapSetting temp;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.sh(), left: 81.sw()),
              child: Text(
                'Map Settings',
                style: kTextStyleInterSemiBold.copyWith(
                    fontSize: 21.ssp(), color: primaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 43.sh(), left: 73.sw()),
              child: Container(
                width: 816.sw(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSlider(
                      text: 'Zoom Factor',
                      max: 10,
                      min: 0,
                      onChanged: (val) {},
                      value: mapSetting.zoom,
                    ),
                    SizedBox(
                      height: 23.sh(),
                    ),
                    const TextWithDDownButton(text: 'Stroke Width'),
                    SizedBox(
                      height: 23.sh(),
                    ),
                    const TextWithDDownButton(text: 'Scroll Zoom in'),
                    SizedBox(
                      height: 23.sh(),
                    ),
                    Text(
                      'Sample Quality',
                      style:
                          kTextStyleInterRegular.copyWith(fontSize: 22.ssp()),
                    ),
                    SizedBox(
                      height: 18.sh(),
                    ),
                    CustomSlider(
                      text: 'Original Map Quality',
                      min: 0,
                      max: 720,
                      onChanged: (val) {},
                      value: mapSetting.sample.original.toDouble(),
                    ),
                    SizedBox(
                      height: 33.sh(),
                    ),
                    CustomSlider(
                        text: 'View Map Quality',
                        max: 720,
                        min: 0,
                        onChanged: (val) {},
                        value: mapSetting.sample.view.toDouble()),
                    SizedBox(
                      height: 33.sh(),
                    ),
                    CustomSlider(
                      text: 'Original Mini Map Quality',
                      max: 120,
                      min: 0,
                      onChanged: (val) {},
                      value: mapSetting.sample.miniMap.toDouble(),
                    ),
                    SizedBox(
                      height: 56.sh(),
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
                              value: mapSetting.defaultLocation.enabled,
                              onChanged: (value) {}),
                        )
                      ],
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
                                details:
                                    mapSetting.defaultLocation.lat.toString(),
                              ),
                              SizedBox(width: 11.sw()),
                              VideoDetailText(
                                title: 'Longitutde',
                                details:
                                    mapSetting.defaultLocation.lng.toString(),
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
                      onChanged: (val) {},
                    ),
                    SizedBox(
                      height: 23.sh(),
                    ),
                    SizedBox(
                      height: 96.sh(),
                    ),
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
                            //     mapSetting: mapSetting..filterCount = 0);
                          },
                          child: Text(
                            'Apply',
                            style: kTextStyleIbmMedium.copyWith(
                                color: Colors.white, fontSize: 17.ssp()),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 120.sh()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
