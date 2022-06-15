import 'package:videomanager/screens/components/contextmenu/contextmenu.dart';
import 'package:videomanager/screens/holder/components/menuitemwidget.dart';
import 'package:videomanager/screens/others/exporter.dart';

class MenuBar extends ConsumerWidget {
  MenuBar({Key? key, required this.indexState}) : super(key: key);

  List<CustomMenuItem> items = [
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
    final index = ref.watch(indexState.state).state;
    final button = ref.watch(buttonProvider.state).state;

    //onPressed
    final height = 101.h;
    return Container(
      height: height,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(top: 26.h, left: 36.w, bottom: 13.h),
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
                    width: 100.w,
                  );
                },
                itemCount: 4,
              ),
            ),
          ),
          // Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 13.h, right: 61.08.w, bottom: 13.h),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 30.sr(),
                    backgroundColor: Colors.teal,
                    child: Container()),
                SizedBox(
                  width: 18.w,
                ),
                PopupMenuButton(
                  offset: Offset(0, height / 2 + 22.sp),
                  itemBuilder: (BuildContext context) {
                    return [PopupMenuItem(child: Text('Change here'))];
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 180.sw(),
                        child: Text(
                          maxLines: 2,
                          'Suman Dangol ascasdasdasdasdazsccccccccccccccccccccccc dwaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaas',
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 17.ssp(min: 10), color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Icon(
                        (button) ? Videomanager.down : Videomanager.up,
                        color: Colors.white,
                        size: 15.r,
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
