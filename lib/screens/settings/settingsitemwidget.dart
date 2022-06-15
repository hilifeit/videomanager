import 'package:videomanager/screens/others/exporter.dart';

class SettingItem {
  SettingItem({required this.title, required this.icon, required this.id});
  String title;
  IconData icon;
  int id;


}


class SettingsItemWidget extends ConsumerWidget {
    SettingsItemWidget({required this.settingsIndexState,  required this.item, Key? key}) : super(key: key);
  final SettingItem item;
  final StateProvider settingsIndexState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          ref.read(settingsIndexState.state).state = item.id;
        },
        child: Row(
          children: [
            Icon(item.icon,size: 21.25.r,),
            SizedBox(width:13.56.w),
            Text(item.title,style: kTextStyleIbmRegular.copyWith(color: Colors.black),),
          ],
        )),
    );
  }
}