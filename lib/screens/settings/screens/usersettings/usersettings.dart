import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/settings/screens/usersettings/models/usersetting.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

// ignore: must_be_immutable
class UserSettings extends ConsumerWidget {
  UserSettings({required this.userSetting, Key? key}) : super(key: key);
  final UserSetting userSetting;
  late UserSetting temp = UserSetting.fromJson(userSetting.toJson());

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
          ),
          child: SizedBox(
            width: 816.sw(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Settings',
                  style: kTextStyleInterSemiBold.copyWith(
                      fontSize: 21.ssp(), color: primaryColor),
                ),
                SizedBox(
                  height: 43.sh(),
                ),
                CustomSliderRectThumb(
                    text: 'Number of video per user',
                    min: 1,
                    max: 200,
                    value: userSetting.videoPerUser.toDouble(),
                    onChanged: (val) {
                      temp.videoPerUser = val.toInt();
                    }),
                SizedBox(
                  height: 105.sh(),
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
                                    var setting =
                                        ref.read(settingChangeNotifierProvider);

                                    await setting.updateSetting(
                                        userSetting:
                                            defaultSetting.userSetting);
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
                                        userSetting: temp);
                                    snack.success(
                                        'Settings Updated Sucessfully');
                                  } catch (e) {
                                    snack.error(e);
                                  }
                                });
                          });
                    }),

                // OutlineAndElevatedButton(
                //   textSecond: 'apply the following settings?',
                //   reset: true,
                //   onReset: () {
                //     var setting = ref.read(settingChangeNotifierProvider);

                //     setting.updateSetting(
                //         userSetting: defaultSetting.userSetting);
                //   },
                //   onApply: () {},
                //   onSucess: () {
                //     var setting = ref.read(settingChangeNotifierProvider);

                //     setting.updateSetting(userSetting: temp);
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
