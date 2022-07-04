import 'package:videomanager/screens/others/exporter.dart';

class CustomMenuItem {
  CustomMenuItem({required this.title, required this.icon, required this.id});
  String title;
  IconData icon;
  int id;
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
              Icon(
                item.icon,
                color: index == item.id ? Colors.white : lightGrey,
                size: 18.sr(),
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
