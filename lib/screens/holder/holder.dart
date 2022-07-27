import 'package:map/map.dart';
<<<<<<< HEAD
=======
import 'package:videomanager/screens/chat/chatHolder.dart';
import 'package:videomanager/screens/dashboard/dashboard.dart';
>>>>>>> a3af68df31b8609d8c2bff883944b6b0c9aca093
import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/holder/components/profilemenu.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/addshop.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/videoassignedcard.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotDashboard.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/users/users.dart';
import 'package:videomanager/screens/viewscreen/components/filter.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'package:videomanager/screens/viewscreen/viewscreen.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

class Holder extends ConsumerWidget {
  Holder({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = MapController(
    location: home,
  );

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
    final userFiles = ref.watch(fileDetailMiniServiceProvider).userFiles;
    final selectedVideo = ref.watch(assignCardSelectProvider.state).state;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: secondaryColor,
        drawer: Drawer(
          child: Filter(mapController: controller),
        ),
        appBar: !ResponsiveLayout.isDesktop
            ? PreferredSize(
                preferredSize:
                    const Size.fromHeight(kBottomNavigationBarHeight),
                child: Container(
                  height: kBottomNavigationBarHeight,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          )),
                      const Spacer(
                        flex: 2,
                      ),
                      Expanded(child: FittedBox(child: ProfileMenu()))
                    ],
                  ),
                ),
              )
            : null,
        body: Column(
          children: [
            if (ResponsiveLayout.isDesktop)
              MenuBar(
                indexState: indexProvider,
              ),
            (thisUser!.role > 0)
                ? Expanded(
                    child: index != 4
                        ? AnimatedIndexedStack(index: index, children: [
                            ViewScreen(),
                            const Users(),
                            AddEditShop(),
                            ChatHolder(),
                            // futureBuilder
                            // PlayVideo(videoFile: videoFile, role: role),
                          ])
                        : const SettingsHolder(),
                  )
                : Expanded(
                    child: index != 1
                        ? AnimatedIndexedStack(index: index, children: [
                            // DashBoard(),
                            userFiles.isNotEmpty
                                ? ScreenshotDashboard(
                                    thisUser: thisUser,
                                    selectedVideo: selectedVideo,
                                  )
                                : NoTask(),
                          ])
                        : const SettingsHolder(),
                  ),
          ],
        ),
        bottomNavigationBar: !ResponsiveLayout.isDesktop
            ? BottomNavigationBar(
                // backgroundColor: Colors.red,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor:
                    Theme.of(context).primaryColor.withAlpha(120),
                showUnselectedLabels: true,
                currentIndex: index,
                onTap: (value) {
                  ref.read(indexProvider.state).state = value;
                },
                items: (thisUser.role > 0)
                    ? [
                        const BottomNavigationBarItem(
                            label: 'Dashboard',
                            icon: Icon(Videomanager.dashboard)),
                        const BottomNavigationBarItem(
                            label: 'Users', icon: Icon(Videomanager.users)),
                        const BottomNavigationBarItem(
                            label: 'Outlets', icon: Icon(Videomanager.outlets)),
                        const BottomNavigationBarItem(
                            label: 'Chat', icon: Icon(Icons.chat)),
                        const BottomNavigationBarItem(
                            label: "Settings",
                            icon: Icon(Videomanager.settings))
                      ]
                    : [
                        const BottomNavigationBarItem(
                            label: 'Dashboard',
                            icon: Icon(Videomanager.dashboard)),
                        const BottomNavigationBarItem(
                            label: "Settings",
                            icon: Icon(Videomanager.settings))
                      ],
              )
            : null,
      ),
    );
  }
}

class NoTask extends StatelessWidget {
  NoTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Take a break! You have no tasks.'),
    );
  }
}
