import 'package:videomanager/screens/auth/login/login.dart';
import 'package:videomanager/screens/others/exporter.dart';

class Loader extends ConsumerWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomKeys().init(ref);
    return Stack(
      children: [
        Login(),
        // if (snackVisible)

        Consumer(builder: (context, ref, c) {
          final snackVisible = ref.watch(snackVisibleProvider.state).state;
          return Positioned(
            top: 10,
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
