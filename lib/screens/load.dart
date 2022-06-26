import 'package:videomanager/screens/auth/auth.dart';
import 'package:videomanager/screens/dashboard/dashboard.dart';
import 'package:videomanager/screens/holder/holder.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

final loginStateProvider = StateProvider<bool>((ref) {
  var user = storage.read("users");
  if (user != null) {
    ref.read(userChangeProvider);
    return false;
  }
  return true;
});

class Loader extends ConsumerWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomKeys().init(ref);
    final isLogin = ref.watch(loginStateProvider.state).state;
    return Stack(
      children: [
        isLogin ? const AuthScreen() : const Holder(),
        // AnimatedCrossFade(
        //     firstChild: const AuthScreen(),
        //     secondChild: const Holder(),
        //     crossFadeState:
        //         isLogin ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        //     duration: const Duration(milliseconds: 800)),

        // if (snackVisible)

        Consumer(builder: (context, ref, c) {
          final snackVisible = ref.watch(snackVisibleProvider.state).state;
          return Positioned(
            top: 120.sh(),
            right: 10,
            child: SizedBox(
              height: 44,
              width: 345,
              // width: snackVisible ? 300 : 1,
              // height: snackVisible ? 55 : 1,
              child: ScaffoldMessenger(
                  key: CustomKeys().messengerKey,
                  child: const Scaffold(
                    backgroundColor: Colors.transparent,
                  )),
            ),
          );
        })
      ],
    );
  }
}
