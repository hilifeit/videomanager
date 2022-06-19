import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/settings/screens/usersettings/models/usersetting.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

class UserSettings extends ConsumerWidget {
  UserSettings({required this.userSetting, Key? key}) : super(key: key);
  final UserSetting userSetting;
  late UserSetting temp = UserSetting.fromJson(userSetting.toJson());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  'User Settings',
                  style: kTextStyleInterSemiBold.copyWith(
                      fontSize: 21.ssp(), color: primaryColor),
                ),
                SizedBox(
                  height: 43.sh(),
                ),
                CustomSlider(
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
                OutlineAndElevatedButton(
                  onApply: () {},
                  onSucess: () {
                    var setting = ref.read(settingChangeNotifierProvider);

                    setting.updateSetting(userSetting: temp);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
