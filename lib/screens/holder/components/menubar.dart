import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:videomanager/screens/holder/components/menuitemwidget.dart';
import 'package:videomanager/screens/others/constant.dart';
import 'package:videomanager/videomanager_icons.dart';

class MenuBar extends ConsumerWidget {
  MenuBar({Key? key, required this.indexState}) : super(key: key);

  List<CustomMenuItem> items = [
    CustomMenuItem(title: 'Dashboard', icon: Videomanager.dashboard, id: 0),
    CustomMenuItem(title: 'Users', icon: Videomanager.users, id: 1),
    CustomMenuItem(title: 'Outlets', icon: Videomanager.outlets, id: 2),
    CustomMenuItem(title: 'Settings', icon: Videomanager.settings, id: 3),
  ];

  final StateProvider<int> indexState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexState.state).state;

    //onPressed
    return Container(
      height: 101.h,
      width: double.infinity,
      color: primaryColor,
      child: Padding(
        padding: EdgeInsets.only(top: 24.h,left: 36.w),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
          return MenuItemWidget(
                    indexState: indexState,
                    item: items[index],
                  );
        }, separatorBuilder: (_,index){
          return SizedBox(
            width: 100.w,
          );
        }, itemCount: items.length,
      ),
    ));
  }
}
