import 'package:videomanager/screens/others/exporter.dart';

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
        color: item.id == selectedIndex
            ? Theme.of(context).primaryColor
            : Colors.transparent,
        child: InkWell(
            onTap: () {
              ref.read(settingsIndexState.state).state = item.id;
            },
            child: Transform.scale(
              scale: item.id == selectedIndex ? 1.05 : 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 43.sw(), vertical: 18.sh()),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 21.25.sr(),
                      color: item.id == selectedIndex
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 16.sw()),
                    Text(
                      item.title,
                      style: kTextStyleIbmRegular.copyWith(
                          color: item.id == selectedIndex
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16.ssp()),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
