import 'package:videomanager/screens/dashboard/component/filemodelsource.dart';
import 'package:videomanager/screens/holder/components/menuitemwidget.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

class MenuBar extends ConsumerWidget {
  MenuBar({Key? key, required this.indexState}) : super(key: key);

  final List<CustomMenuItem> items = [
    CustomMenuItem(
        title: 'Dashboard',
        icon: Videomanager.dashboard,
        id: 0,
        notify: true,
        number: 50),
    CustomMenuItem(
        title: 'Users',
        icon: Videomanager.users,
        id: 1,
        notify: true,
        number: 1),
    CustomMenuItem(
      title: 'Outlets',
      icon: Videomanager.outlets,
      id: 2,
      notify: true,
      number: 60000,
    ),
    CustomMenuItem(title: 'Play Video', icon: Videomanager.play_video, id: 3),
    CustomMenuItem(title: 'Settings', icon: Videomanager.settings, id: 4),

    //  CustomMenuItem(title: 'Text', icon: Videomanager.settings, id: 4),
  ];
  final List<CustomMenuItem> itemsUser = [
    CustomMenuItem(title: 'Dashboard', icon: Videomanager.dashboard, id: 0),
    CustomMenuItem(title: 'Settings', icon: Videomanager.settings, id: 1),
    //  CustomMenuItem(title: 'Text', icon: Videomanager.settings, id: 4),
  ];

  final StateProvider<int> indexState;
  final buttonProvider = StateProvider<bool>((ref) {
    return true;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final index = ref.watch(indexState.state).state;
    final thisUser = ref.watch(userChangeProvider).loggedInUser.value;
    final button = ref.watch(buttonProvider.state).state;

    //onPressed
    final height = 101.sh();
    return Container(
      height: height,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 26.sh(), left: 36.sw(), bottom: 13.sh()),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MenuItemWidget(
                      indexState: indexState,
                      item:
                          thisUser!.role > 0 ? items[index] : itemsUser[index]);
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    width: 100.sw(),
                  );
                },
                itemCount: thisUser!.role > 0 ? items.length : itemsUser.length,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                var currentUser = ref.read(userChangeProvider);

                customSocket.socket.emit("notification",
                    "New Notification from ${currentUser.loggedInUser.value!.name}");
              },
              tooltip: "Send Notificattion",
              icon: const Icon(
                Icons.send_sharp,
                color: Colors.white,
              )),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
                top: 13.sh(), right: 61.08.sw(), bottom: 13.sh()),
            child: PopupMenuButton(
              offset: Offset(0, height / 2 + 22.ssp()),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      onTap: () async {
                        Future.delayed(const Duration(milliseconds: 1), () {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    textSecond: 'logout?',
                                    elevatedButtonText: 'Yes',
                                    onPressedElevated: () async {
                                      logout();
                                    });
                              });
                        });
                      },
                      child: CustomPopUpMenuItemChild(
                          icon: Videomanager.logout, text: 'Logout'))
                ];
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 180.sw(),
                    child: Text(
                      maxLines: 2,
                      // "asdsad",
                      // userName.user.username,
                      thisUser.name,

                      style: kTextStyleIbmSemiBold.copyWith(
                          fontSize: 17.ssp(min: 10), color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20.sw(),
                  ),
                  Icon(
                    (button) ? Videomanager.down : Videomanager.up,
                    color: Colors.white,
                    size: 15.sr(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
