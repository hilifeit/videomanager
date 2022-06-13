import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:videomanager/screens/others/constant.dart';

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
            children: [
              Icon(
                item.icon,
                color:
                    index == item.id ? Colors.white : const Color(0xffd1d1d1),
                size: 18.r,
              ),
              SizedBox(
                height: 5.82.h,
              ),
              Center(
                child: Text(
                  item.title,
                  style: kTextStyleIbmSemiBold.copyWith(
                    fontSize: 17.sp.sm,
                    color:
                        index == item.id ? Colors.white : const Color(0xffd1d1d1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
