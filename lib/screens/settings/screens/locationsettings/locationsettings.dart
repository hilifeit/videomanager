import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/customswitch.dart';
import 'package:videomanager/screens/settings/screens/locationsettings/models/locationsetting.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

// ignore: must_be_immutable
class LocationSettings extends ConsumerWidget {
  LocationSettings({required this.locationSetting, Key? key}) : super(key: key);
  final LocationSetting locationSetting;
  late LocationSetting temp =
      LocationSetting.fromJson(locationSetting.toJson());
  late final valueProvider = StateProvider<bool>((ref) {
    return temp.starvaFile;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final starvaFile = ref.watch(valueProvider.state).state;
    final defaultSetting = ref.watch(defaultSettingProvider.state).state;
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
                  value: starvaFile,
                  text: "Allow Starva File Upload",
                  onChanged: (val) {
                    ref.read(valueProvider.state).state = val;
                    temp.starvaFile = val;
                  },
                  space: 566.sw(),
                ),
                SizedBox(
                  height: 85.sw(),
                ),

                OutlinedElevatedButtonCombo(
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
                                    var setting =
                                        ref.read(settingChangeNotifierProvider);

                                    await setting.updateSetting(
                                        locationSetting:
                                            defaultSetting.locationSetting);
                                    snack.success('Settings Reset Sucessful');
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
                                    var setting =
                                        ref.read(settingChangeNotifierProvider);

                                    await setting.updateSetting(
                                        locationSetting: temp);
                                    snack.success(
                                        'Settings Updated Sucessfully');
                                  } catch (e) {
                                    snack.error(e);
                                  }
                                });
                          });
                    }),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
