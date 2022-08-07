import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/locationsettings/locationsettings.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/mapsettings.dart';
import 'package:videomanager/screens/settings/screens/usersettings/usersettings.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videosetting.dart';
import 'package:videomanager/screens/settings/screens/videosettings/videosettings.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

class SettingItem {
  SettingItem({required this.title, required this.icon, required this.id});
  String title;
  IconData icon;
  int id;
}

class SettingsItemWidget extends ConsumerWidget {
  const SettingsItemWidget(
      {required this.settingsIndexState, required this.item, Key? key})
      : super(key: key);
  final SettingItem item;
  final StateProvider settingsIndexState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(settingsIndexState.state).state;
    return MouseRegion(
      // cursor: SystemMouseCursors.click,
      child: Material(
        color: ResponsiveLayout.isDesktop
            ? item.id == selectedIndex
                ? Theme.of(context).primaryColor
                : Colors.transparent
            : Colors.transparent,
        child: InkWell(
            onTap: () {
              ref.read(settingsIndexState.state).state = item.id;
              if (ref.watch(settingsIndexState.state).state == 0 &&
                  !ResponsiveLayout.isDesktop) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapSettings(
                    mapSetting: setting.mapSetting,
                  );
                }));
              }
              if (ref.watch(settingsIndexState.state).state == 1 &&
                  !ResponsiveLayout.isDesktop) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VideoSettings(
                    videoSetting: setting.videoSetting,
                  );
                }));
              }
              if (ref.watch(settingsIndexState.state).state == 2 &&
                  !ResponsiveLayout.isDesktop) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UserSettings(userSetting: setting.userSetting);
                }));
              }
              if (ref.watch(settingsIndexState.state).state == 3 &&
                  !ResponsiveLayout.isDesktop) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LocationSettings(
                      locationSetting: setting.locationSetting);
                }));
              }
            },
            child: Transform.scale(
              scale: ResponsiveLayout.isDesktop
                  ? item.id == selectedIndex
                      ? 1.05
                      : 1
                  : 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 43.sw(), vertical: 18.sh()),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 21.25.sr(),
                      color: ResponsiveLayout.isDesktop
                          ? item.id == selectedIndex
                              ? Colors.white
                              : Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 16.sw()),
                    Text(
                      item.title,
                      style: kTextStyleIbmRegular.copyWith(
                          color: ResponsiveLayout.isDesktop
                              ? item.id == selectedIndex
                                  ? Colors.white
                                  : Colors.black
                              : Colors.black,
                          fontSize: 16.ssp()),
                    ),
                    if (!ResponsiveLayout.isDesktop) ...[
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18.sr(),
                      )
                    ]
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
