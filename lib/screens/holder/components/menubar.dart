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
  ];

  final StateProvider<int> indexState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexState.state).state;

    //onPressed
    return Container(
      height: 101.h,
      color: primaryColor,
      child: Row(
        children: items
            .map((e) => MenuItemWidget(
                  indexState: indexState,
                  item: e,
                ))
            .toList(),
      ),
    );
  }
}
