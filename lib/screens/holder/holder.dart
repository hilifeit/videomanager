import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:videomanager/screens/components/animatedindexedstack.dart';

import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/video/video.dart';
import 'package:videomanager/screens/viewscreen/viewscreen.dart';

final IndexProvider = StateProvider<int>((ref) {
  return 0;
});

class Holder extends ConsumerWidget {
  Holder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(IndexProvider.state).state;

    return Scaffold(
      body: Column(
        children: [
          MenuBar(
            indexState: IndexProvider,
          ),
          Expanded(
            child: AnimatedIndexedStack(
                index: index, children: [ViewScreen(), Video(), Container(), Container()]),
          )
        ],
      ),
    );
  }
}
