import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/usersettings/models/usersetting.dart';

class UserSettings extends ConsumerWidget {
  const UserSettings({required this.userSetting, Key? key}) : super(key: key);
  final UserSetting userSetting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 43.sh(), left: 73.sw()),
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
            Row(children: [
              Text('Number of video per user', style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),),
            SizedBox(width: 121.sw(),
            ),
            Placeholder(
              fallbackWidth: 106.sw(),
              fallbackHeight: 49.sh(),)
            ],),
            SizedBox(height: 27.sh(),),
            Row(children: [
              Text('Add user',style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),),
              SizedBox(width: 335.sw(),),
              InkWell(
                onTap: (){},
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 12.sr(),
                  child: Icon(Icons.add,color: Colors.white,size: 20.ssp(),),
                ),
              ),
            ],),
            SizedBox(
              height: 105.sh(),
            ),
           const OutlineAndElevatedButton()
            ],
          ),
        ),
      ),
    );
  }
}
