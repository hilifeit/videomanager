import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/users.dart';
import 'package:videomanager/screens/viewscreen/viewscreen.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

class Holder extends ConsumerWidget {
  const Holder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomKeys().init(ref);
    final index = ref.watch(indexProvider.state).state;

    return Scaffold(
      body: Column(
        children: [
          MenuBar(
            indexState: indexProvider,
          ),
          Expanded(
            child: index != 3
                ? AnimatedIndexedStack(
                    index: index,
                    children: [ViewScreen(), Users(), Container()])
                : const SettingsHolder(),
          )
        ],
      ),
    );
  }
}
