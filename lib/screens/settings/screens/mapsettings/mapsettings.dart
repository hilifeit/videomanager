import 'package:videomanager/screens/components/customdialogbox/customdialogbox.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/mapdefault.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting_model.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

class MapSettings extends ConsumerWidget {
  MapSettings({Key? key, required this.mapSetting}) : super(key: key);
  final MapSetting mapSetting;

  late MapSetting temp = MapSetting.fromJson(mapSetting.toJson());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultSetting = ref.watch(defaultSettingProvider.state).state;
    return Scaffold(
        appBar: !ResponsiveLayout.isDesktop ? AppBar() : null,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 43.sh(),
              left: ResponsiveLayout.isDesktop ? 73.sw() : 20.sw(),
              // right: ResponsiveLayout.isDesktop ? 73.sw() : 20.sw(),
            ),
            child: SizedBox(
              width: 816.sw(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Map Settings',
                      style: kTextStyleInterSemiBold.copyWith(
                          fontSize: 21.ssp(), color: primaryColor),
                    ),
                    SizedBox(
                      height: 43.sh(),
                    ),
                    CustomSliderRectThumb(
                      text: 'Zoom Factor',
                      max: 10,
                      min: 1,
                      onChanged: (val) {
                        temp.zoom = val;
                      },
                      value: mapSetting.zoom,
                    ),
                    SizedBox(
                      height: 23.sh(),
                    ),
                    CustomDropDown<int>(
                      values: const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
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
                    CustomDropDown<int>(
                      values: const [10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
                      text: 'Scroll Zoom in',
                      value: mapSetting.scroll,
                      helperText: "%",
                      onChanged: (val) {
                        temp.scroll = val;
                      },
                    ),
                    SizedBox(
                      height: 42.sh(),
                    ),
                    Text(
                      'Sample Quality',
                      style:
                          kTextStyleInterRegular.copyWith(fontSize: 22.ssp()),
                    ),
                    SizedBox(
                      height: 18.sh(),
                    ),
                    CustomSliderRectThumb(
                      text: 'Original Map Quality',
                      min: 0,
                      max: 100,
                      onChanged: (val) {
                        temp.sample.original = val.toInt();
                      },
                      value: mapSetting.sample.original.toDouble(),
                    ),
                    SizedBox(
                      height: 33.sh(),
                    ),
                    CustomSliderRectThumb(
                        text: 'View Map Quality',
                        max: 100,
                        min: 0,
                        onChanged: (val) {
                          temp.sample.view = val.toInt();
                        },
                        value: mapSetting.sample.view.toDouble()),
                    SizedBox(
                      height: 33.sh(),
                    ),
                    CustomSliderRectThumb(
                      text: 'Original Mini Map Quality',
                      max: 100,
                      min: 0,
                      onChanged: (val) {
                        temp.sample.miniMap = val.toInt();
                      },
                      value: mapSetting.sample.miniMap.toDouble(),
                    ),
                    SizedBox(
                      height: 56.sh(),
                    ),
                    MapDefaultLocation(
                      temp: temp,
                    ),
                    SizedBox(
                      height: 23.sh(),
                    ),
                    CustomSliderRectThumb(
                      text: 'Suggestion / Result Count',
                      max: 10,
                      min: 1,
                      value: mapSetting.filterCount.toDouble(),
                      onChanged: (val) {
                        temp.filterCount = val.toInt();
                      },
                    ),
                    SizedBox(
                      height: 55.sh(),
                    ),
                    OutlinedElevatedButtonCombo(
                        center: ResponsiveLayout.isMobile ? true : false,
                        outlinedButtonText: 'Reset',
                        elevatedButtonText: 'Apply',
                        onPressedOutlined: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    textSecond: 'reset the following settings?',
                                    elevatedButtonText: 'Yes',
                                    onPressedElevated: () async {
                                      try {
                                        var setting = ref.read(
                                            settingChangeNotifierProvider);

                                        await setting.updateSetting(
                                            mapSetting:
                                                defaultSetting.mapSetting);
                                        snack.success(
                                            'Settings Reset Sucessful');
                                      } catch (e) {
                                        snack.error(e);
                                      }
                                    });
                              });
                        },
                        onPressedElevated: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    elevatedButtonText: 'Yes',
                                    textSecond: 'apply the following settings?',
                                    onPressedElevated: () async {
                                      try {
                                        var setting = ref.read(
                                            settingChangeNotifierProvider);

                                        await setting.updateSetting(
                                            mapSetting: temp);
                                        snack.success(
                                            'Settings Updated Sucessfully');
                                      } catch (e) {
                                        snack.error(e);
                                      }
                                    });
                              });
                        }),
                    SizedBox(height: 20.sh()),
                  ]),
            ),
          ),
        ));
  }
}
