import 'dart:math';

import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/settingsbar.dart';
import 'package:videomanager/screens/settings/screens/locationsettings/locationsettings.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/mapsettings.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting_model.dart';
import 'package:videomanager/screens/settings/screens/usersettings/usersettings.dart';
import 'package:videomanager/screens/settings/screens/videosettings/videosettings.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

final settingIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class SettingsHolder extends ConsumerWidget {
  const SettingsHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsindex = ref.watch(settingIndexProvider.state).state;
    final setting = ref.watch(settingChangeNotifierProvider).setting;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: SettingsBar(
            settingsIndexState: settingIndexProvider,
          )),
          if (ResponsiveLayout.isDesktop) ...[
            const VerticalDivider(
              width: 0,
            ),
            Expanded(
                flex: 5,
                child: (() {
                  if (settingsindex == 0) {
                    return MapSettings(
                      mapSetting: setting.mapSetting,
                    );
                  }
                  if (settingsindex == 1) {
                    return VideoSettings(
                      videoSetting: setting.videoSetting,
                    );
                  }
                  if (settingsindex == 2) {
                    return UserSettings(
                      userSetting: setting.userSetting,
                    );
                  }
                  if (settingsindex == 3) {
                    return LocationSettings(
                      locationSetting: setting.locationSetting,
                    );
                  }

                  return Container(
                    color: Colors.amber,
                  );
                }())),
          ],
          // Expanded(
          //   child: Playback(
          //     onChanged: (playbackspeed) {
          //       print(playbackspeed);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
