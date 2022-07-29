import 'package:videomanager/screens/holder/components/menuitemwidget.dart';
import 'package:videomanager/screens/holder/components/profilemenu.dart';
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
    CustomMenuItem(title: 'Chat', icon: Icons.chat, id: 3),
    CustomMenuItem(title: 'Settings', icon: Videomanager.settings, id: 4),

    //  CustomMenuItem(title: 'Text', icon: Videomanager.settings, id: 4),
  ];
  final List<CustomMenuItem> itemsUser = [
    CustomMenuItem(title: 'Dashboard', icon: Videomanager.dashboard, id: 0),
    CustomMenuItem(title: 'Chat', icon: Icons.chat, id: 1),
    CustomMenuItem(title: 'Settings', icon: Videomanager.settings, id: 2),
    //  CustomMenuItem(title: 'Text', icon: Videomanager.settings, id: 4),
  ];

  final StateProvider<int> indexState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final index = ref.watch(indexState.state).state;
    final thisUser = ref.watch(userChangeProvider).loggedInUser.value;

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
          ProfileMenu(),
        ],
      ),
    );
  }
}
