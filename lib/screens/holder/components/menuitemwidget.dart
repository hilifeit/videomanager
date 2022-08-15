import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/component/userService.dart';

class CustomMenuItem {
  CustomMenuItem(
      {required this.title,
      required this.icon,
      required this.id,
      this.notify = false,
      this.number});
  String title;
  IconData icon;
  int id;
  bool notify;
  int? number;
}

class MenuItemWidget extends ConsumerWidget {
  const MenuItemWidget({
    Key? key,
    required this.indexState,
    required this.item,
  }) : super(key: key);
  final CustomMenuItem item;
  final StateProvider<int> indexState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexState.state).state;
    final thisUser = ref.watch(userChangeProvider).loggedInUser.value;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (() {
          if (thisUser!.role == Roles.user.index) {
            ref.read(settingIndexProvider.state).state = 1;
          }
          ref.read(indexState.state).state = item.id;
          final customOverlay = CustomOverlayEntry();

          if (customOverlay.videoTimeStampOpen) {
            customOverlay.closeVideoTimeStamp();
          }
          if (customOverlay.isFilterMenuOpen) {
            customOverlay.closeFilter();
          }
          // if (item.id == 3 && !customOverlay.videoTimeStampOpen) {
          //   customOverlay.showVideoTimeStamp();
          // }
        }),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.sw()),
                    child: Icon(
                      item.icon,
                      color: index == item.id ? Colors.white : lightGrey,
                      size: 18.sr(),
                    ),
                  ),
                  if (item.notify && item.number != null)
                    if (item.number != 0) notify(context),
                  if (item.notify && item.number == null) notify(context)
                ],
              ),
              SizedBox(
                height: 5.82.sh(),
              ),
              Text(
                item.title,
                style: kTextStyleIbmSemiBold.copyWith(
                  fontSize: 17.ssp(),
                  color: index == item.id ? Colors.white : lightGrey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Positioned notify(BuildContext context) {
    return Positioned(
      right: -5,
      top: -8,
      child: CircleAvatar(
        radius: (19 / 2).sr(),
        backgroundColor: primaryColor,
        child: Container(
          padding: EdgeInsets.all(2.sr()),
          decoration: const BoxDecoration(
              color: Color(0xffFFD0D5), shape: BoxShape.circle
              // borderRadius: BorderRadius.circular(8.565.sr()),
              ),
          constraints: BoxConstraints(
            minWidth: 17.13.sr(),
            minHeight: 17.13.sr(),
          ),
          child: FittedBox(
            child: item.number != null
                ? Text(
                    item.number! < 10 ? item.number.toString() : '9+',
                    style: kTextStyleIbmSemiBold.copyWith(
                      fontSize: 10.ssp(),
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Icon(
                    Icons.portable_wifi_off,
                    color: Theme.of(context).primaryColor,
                  ),
          ),
        ),
      ),
    );
  }
}
