import 'package:map/map.dart';
import 'package:videomanager/screens/Bug/screen/bugscreen.dart';
import 'package:videomanager/screens/chat/chatHolder.dart';
import 'package:videomanager/screens/components/helper/customSafeArea.dart';
import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/holder/components/profilemenu.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotDashboardHolder.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/users/users.dart';
import 'package:videomanager/screens/viewscreen/components/filter.dart';
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
  final scaleProvider = StateProvider<double>((ref) {
    return 1.0;
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomKeys().init(ref, context);
    final index = ref.watch(indexProvider.state).state;

    final userProvider = ref.watch(userChangeProvider);
    final thisUser = userProvider.loggedInUser.value;

    // if (thisUser != null) {
    //   if (thisUser.role != Roles.user.index && userProvider.users.isEmpty) {
    //     userProvider.fetchAll();
    //   }
    // }
    // if (thisUser!.role == Roles.user.index) {
    //   ref.read(settingIndexProvider.state).state = 1;
    // }

    return CustomSafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: secondaryColor,
        drawer: ResponsiveLayout.isDesktop
            ? null
            : Drawer(
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
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(right: 10.sw()),
                        child: FittedBox(child: ProfileMenu()),
                      ))
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
            (thisUser!.role == Roles.superAdmin.index)
                ? Expanded(
                    child: index != 5
                        ? AnimatedIndexedStack(index: index, children: [
                            ViewScreen(),
                            const Users(),
                            // Container(
                            //   color: Colors.red,
                            // ),
                            Container(),
                            const ChatHolder(),

                            BugScreen(
                                isActive: true,
                                user: UserModelMini(
                                    id: '1',
                                    name: 'Shruti',
                                    role: 1,
                                    createdAt: DateTime.now()))

                            // Container() // Bug()

                            // futureBuilder
                            // PlayVideo(videoFile: videoFile, role: role),
                          ])
                        : const SettingsHolder(),
                  )
                : (thisUser.role == Roles.manager.index)
                    ? Expanded(
                        child: index != 3
                            ? AnimatedIndexedStack(index: index, children: [
                                ScreenshotDashboardHolder(
                                  thisUser: thisUser,
                                ),
                                const Users(),
                                const ChatHolder(),
                                // futureBuilder
                                // PlayVideo(videoFile: videoFile, role: role),
                              ])
                            : const SettingsHolder(),
                      )
                    : Expanded(
                        child: index != 2
                            ? AnimatedIndexedStack(index: index, children: [
                                // DashBoard(),

                                ScreenshotDashboardHolder(
                                  thisUser: thisUser,
                                ),
                                const ChatHolder()
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
                        BottomNavigationBarItem(
                            label: "Bugs",
                            icon: Icon(
                              Icons.bug_report,
                              size: 28.ssp(),
                            )),
                        const BottomNavigationBarItem(
                            label: "Settings",
                            icon: Icon(Videomanager.settings)),
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
    return const Center(
      child: const Text('Take a break! You have no tasks.'),
    );
  }
}
