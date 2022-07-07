import 'package:videomanager/screens/components/componentmaker.dart';
import 'package:videomanager/screens/dashboard/dashboard.dart';
import 'package:videomanager/screens/dashboard/table.dart';
import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/overlay.dart';
import 'package:videomanager/screens/screenshotmanager/screens/playvideo.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/users.dart';
import 'package:videomanager/screens/viewscreen/components/customSearch.dart';
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
    ref.read(userChangeProvider).fetchAll();
    final thisUser = ref.read(userChangeProvider).loggedInUser.value;

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
                          ComponentMaker(),
                          PlayVideo()
                          // PlayVideo()
                        ])
                      : const SettingsHolder(),
                )
              : Expanded(
                  child: index != 1
                      ? AnimatedIndexedStack(index: index, children: [
                          thisUser.role == 0 ? PlayVideo() : ViewScreen(),
                        ])
                      : const SettingsHolder(),
                ),
        ],
      ),
    );
  }
}
