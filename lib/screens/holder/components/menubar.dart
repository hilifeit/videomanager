import 'package:videomanager/screens/holder/components/menuitemwidget.dart';
import 'package:videomanager/screens/holder/components/profilemenu.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

class MenuBar extends ConsumerWidget {
  MenuBar({Key? key, required this.indexState}) : super(key: key);

  late final CustomMenuItem chat = CustomMenuItem(
          title: 'Chat', icon: Icons.chat, id: 3, notify: true, number: 0),
      dashboard = CustomMenuItem(
          title: 'Dashboard',
          icon: Videomanager.dashboard,
          id: 0,
          notify: true,
          number: 50),
      users = CustomMenuItem(
          title: 'Users',
          icon: Videomanager.users,
          id: 1,
          notify: true,
          number: 1),
      outlet = CustomMenuItem(
        title: 'Outlets',
        icon: Videomanager.outlets,
        id: 2,
        notify: true,
        number: 60000,
      ),
      settings =
          CustomMenuItem(title: 'Settings', icon: Videomanager.settings, id: 4);
  late final List<CustomMenuItem> itemsAdmin = [
    dashboard,
    users,
    outlet,
    chat,
    settings

    //  CustomMenuItem(title: 'Text', icon: Videomanager.settings, id: 4),
  ];

  late final List<CustomMenuItem> itemsManager = [
    dashboard,
    users,
    chat,
    settings,
  ];

  late final List<CustomMenuItem> itemsUser = [
    dashboard,
    chat,
    settings,
    //  CustomMenuItem(title: 'Text', icon: Videomanager.settings, id: 4),
  ];

  final StateProvider<int> indexState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final index = ref.watch(indexState.state).state;
    final thisUser = ref.watch(userChangeProvider).loggedInUser.value;
    final connected = ref.watch(CustomSocket.status.state).state;
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
                  final currentItem = thisUser!.role == 2
                      ? itemsAdmin[index]
                      : thisUser.role == 1
                          ? itemsManager[index]
                          : itemsUser[index];
                  currentItem.id = index;
                  if (currentItem.title.toLowerCase() == "chat") {
                    if (connected) {
                      currentItem.number = 0;
                    } else {
                      currentItem.number = null;
                    }
                  }
                  return MenuItemWidget(
                      indexState: indexState, item: currentItem);
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    width: 100.sw(),
                  );
                },
                itemCount: thisUser!.role == 2
                    ? itemsAdmin.length
                    : thisUser.role == 1
                        ? itemsManager.length
                        : itemsUser.length,
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
          ProfileMenu(),
        ],
      ),
    );
  }
}
