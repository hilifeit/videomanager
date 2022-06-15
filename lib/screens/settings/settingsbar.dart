import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/settingsitemwidget.dart';

class SettingsBar extends ConsumerWidget {
  SettingsBar({required this.settingsIndexState, Key? key}) : super(key: key);

  List<SettingItem> items = [
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
      color: const Color(0xff40667d0d).withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.h, left: 43.w),
            child: Text(
              'Settings',
              style: kTextStyleIbmSemiBold.copyWith(
                  color: primaryColor, fontSize: 21.sp),
            ),
          ),
          SizedBox(height: 39.sh()),
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
