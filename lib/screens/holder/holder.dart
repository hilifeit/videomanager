import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/users.dart';
import 'package:videomanager/screens/video/video.dart';
import 'package:videomanager/screens/viewscreen/viewscreen.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});
final snackVisibleProvider = StateProvider<bool>((ref) {
  return false;
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
            child: Stack(
              children: [
                index != 3
                    ? AnimatedIndexedStack(index: index, children: [
                        ViewScreen(),
                        Users(),
                        Video(),
                      ])
                    : const SettingsHolder(),
                // if (snackVisible)

                Consumer(builder: (context, ref, c) {
                  final snackVisible =
                      ref.watch(snackVisibleProvider.state).state;
                  return Positioned(
                    top: 10,
                    right: 10,
                    child: SizedBox(
                      width: snackVisible ? 300 : 1,
                      height: snackVisible ? 55 : 1,
                      child: ScaffoldMessenger(
                          key: CustomKeys().messengerKey,
                          child: const Scaffold(
                            backgroundColor: Colors.transparent,
                          )),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
