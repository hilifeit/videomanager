import 'package:videomanager/screens/dashboard/dashboard.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/users.dart';
import 'package:videomanager/screens/video/video.dart';
import 'package:videomanager/screens/viewscreen/viewscreen.dart';

final IndexProvider = StateProvider<int>((ref) {
  return 0;
});

class Holder extends ConsumerWidget {
  const Holder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(IndexProvider.state).state;

    return Scaffold(
      body: Column(
        children: [
          MenuBar(
            indexState: IndexProvider,
          ),
          index != 3
              ? Expanded(
                  child: AnimatedIndexedStack(index: index, children: [
                    DashBoard(),
                    Users(),
                    Video(),
                  ]),
                )
              : Expanded(child: SettingsHolder())
        ],
      ),
    );
  }
}
