import 'package:videomanager/screens/components/customdialogbox/customdialogbox.dart';
import 'package:videomanager/screens/holder/components/menuitemwidget.dart';
import 'package:videomanager/screens/load.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';

class MenuBar extends ConsumerWidget {
  MenuBar({Key? key, required this.indexState}) : super(key: key);

  final List<CustomMenuItem> items = [
    CustomMenuItem(title: 'Dashboard', icon: Videomanager.dashboard, id: 0),
    CustomMenuItem(title: 'Users', icon: Videomanager.users, id: 1),
    CustomMenuItem(title: 'Outlets', icon: Videomanager.outlets, id: 2),
    CustomMenuItem(title: 'Settings', icon: Videomanager.settings, id: 3),
    //  CustomMenuItem(title: 'Text', icon: Videomanager.settings, id: 4),
  ];

  final StateProvider<int> indexState;
  final buttonProvider = StateProvider<bool>((ref) {
    return true;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final index = ref.watch(indexState.state).state;
    final userName = ref.watch(userChangeProvider).user;
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
                    item: items[index],
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    width: 100.sw(),
                  );
                },
                itemCount: 4,
              ),
            ),
          ),
          // Spacer(),
          Padding(
            padding: EdgeInsets.only(
                top: 13.sh(), right: 61.08.sw(), bottom: 13.sh()),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 30.sr(),
                    backgroundColor: Colors.teal,
                    child: Container()),
                SizedBox(
                  width: 18.sw(),
                ),
                PopupMenuButton(
                  offset: Offset(0, height / 2 + 22.ssp()),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                          onTap: () async {
                            Future.delayed(const Duration(milliseconds: 1), () {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                        textSecond: 'logout?',
                                        onApply: () {},
                                        onSucess: () {
                                          storage.remove('users');
                                          // ref
                                          //     .read(loginStateProvider.state)
                                          //     .state = true;
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const Loader()),
                                              (route) => true);
                                        },
                                        onReset: () {});
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
                          // userName.user.username,
                          userName.name,

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
              ],
            ),
          )
        ],
      ),
    );
  }
}
