import 'package:videomanager/screens/components/compoenttest.dart';
import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/playvideo.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/users/users.dart';
import 'package:videomanager/screens/viewscreen/viewscreen.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

class Holder extends ConsumerWidget {
  const Holder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomKeys().init(ref, context);
    final index = ref.watch(indexProvider.state).state;

    final thisUser = ref.read(userChangeProvider).loggedInUser.value;
    if (thisUser != null) {
      if (thisUser.role != Roles.user.index) {
        ref.read(userChangeProvider).fetchAll();
      }
    }

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          MenuBar(
            indexState: indexProvider,
          ),
          (thisUser!.role > 0)
              ? Expanded(
                  child: index != 4
                      ? AnimatedIndexedStack(index: index, children: [
                          ViewScreen(),
                          const Users(),
                          AddRemarksOnSubmit(),
                          Container()
                          // futureBuilder
                          // PlayVideo(videoFile: videoFile, role: role),
                        ])
                      : const SettingsHolder(),
                )
              : Expanded(
                  child: index != 1
                      ? AnimatedIndexedStack(index: index, children: [
                          PlayVideo(role: thisUser.role),
                        ])
                      : const SettingsHolder(),
                ),
        ],
      ),
    );
  }
}
