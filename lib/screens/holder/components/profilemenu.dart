import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';

class ProfileMenu extends ConsumerWidget {
  ProfileMenu({
    Key? key,
    this.height = 101,
  }) : super(key: key);

  final buttonProvider = StateProvider<bool>((ref) {
    return true;
  });
  final double height;

  @override
  Widget build(BuildContext context, ref) {
    final thisUser = ref.read(userChangeProvider).loggedInUser;
    final button = ref.watch(buttonProvider.state).state;

    return PopupMenuButton(
      offset: ResponsiveLayout.isDesktop
          ? Offset(0, height.sh() / 2 + 22.ssp())
          : const Offset(0, kBottomNavigationBarHeight),
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
      child: Padding(
        padding: EdgeInsets.only(
            top: 13.sh(),
            right: ResponsiveLayout.isDesktop ? 61.08.sw() : 8.sw(),
            bottom: 13.sh()),
        child: Row(
          children: [
            Text(
              maxLines: 2,
              // "asdsad",
              // userName.user.username,
              thisUser.value!.name,

              style: kTextStyleIbmSemiBold.copyWith(
                  fontSize: 17.ssp(min: 10), color: Colors.white),
            ),
            SizedBox(
              width: ResponsiveLayout.isDesktop ? 20.sw() : 5.sw(),
            ),
            Icon(
              (button) ? Videomanager.down : Videomanager.up,
              color: Colors.white,
              size: ResponsiveLayout.isDesktop ? 15.sr() : 9.sr(),
            )
          ],
        ),
      ),
    );
  }
}
