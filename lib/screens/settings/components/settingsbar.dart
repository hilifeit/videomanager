import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/settingsitemwidget.dart';

class SettingsBar extends ConsumerWidget {
  SettingsBar({required this.settingsIndexState, Key? key}) : super(key: key);

  final List<SettingItem> items = [
    SettingItem(title: 'Map Settings', icon: Videomanager.maps, id: 0),
    SettingItem(title: 'Video Settings', icon: Videomanager.video, id: 1),
    SettingItem(title: 'User Settings', icon: Videomanager.usersettings, id: 2),
    SettingItem(
        title: 'Location Settings', icon: Videomanager.location_setting, id: 3),
  ];
  final StateProvider settingsIndexState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: holderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (ResponsiveLayout.isDesktop) ...[
            Padding(
              padding: EdgeInsets.only(top: 15.sh(), left: 43.sw()),
              child: Text(
                'Settings',
                style: kTextStyleIbmSemiBold.copyWith(
                    color: primaryColor, fontSize: 21.ssp()),
              ),
            ),
            SizedBox(height: 39.sh()),
          ],
          Expanded(
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return SettingsItemWidget(
                    settingsIndexState: settingsIndexState,
                    item: items[index],
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: 0.sh(),
                  );
                },
                itemCount: items.length),
          ),
        ],
      ),
    );
  }
}
