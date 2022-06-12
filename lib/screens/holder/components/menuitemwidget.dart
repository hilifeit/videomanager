import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    return Container(
      color: index == item.id ? Colors.white : Colors.transparent,
      child: GestureDetector(
        onTap: () {
          ref.read(indexState.state).state = item.id;
        },
        child: Column(
          children: [Icon(item.icon), Text(item.title)],
        ),
      ),
    );
  }
}
