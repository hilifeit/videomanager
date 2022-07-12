import 'package:videomanager/screens/others/exporter.dart';

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

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (() {
          ref.read(indexState.state).state = item.id;
        }),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
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
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        radius: (16.13 / 2).sr(),
                        backgroundColor: primaryColor,
                        child: Container(
                          padding: EdgeInsets.all(1.sr()),
                          decoration: BoxDecoration(
                            color: Color(0xffFFD0D5),
                            borderRadius: BorderRadius.circular(7.5.sr()),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 15.13.sw(),
                            minHeight: 15.13.sh(),
                          ),
                          child: Text(
                            item.number! < 10 ? item.number.toString() : '9+',
                            style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 10.ssp(),
                              color: primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
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
}
