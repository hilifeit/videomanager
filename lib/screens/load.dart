import 'package:videomanager/screens/auth/auth.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
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
    CustomKeys().init(ref, context);
    CustomOverlayEntry().context = context;
    final isLogin = ref.watch(loginStateProvider.state).state;

    return LayoutBuilder(builder: (context, constraints) {
      return ScreenUtilInit(
        designSize: ResponsiveLayout.checkWidth(constraints),
        builder: (_, child) => child!,
        child: Stack(
          children: [
            isLogin ? const AuthScreen() : Holder(),
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
                top: ResponsiveLayout.isDesktop ? 120.sh() : null,
                bottom: ResponsiveLayout.isDesktop ? null : 60.sh(),
                right: 10,
                child: SizedBox(
                  height: 44,
                  //width: 345,
                  width: snackVisible ? 300 : 1,
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
        ),
      );
    });
  }
}
