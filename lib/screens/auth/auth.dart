import 'package:videomanager/screens/auth/forgotpassword/forgotpassword.dart';
import 'package:videomanager/screens/auth/login/login.dart';
import 'package:videomanager/screens/others/exporter.dart';

final authStateProvider = StateProvider<bool>((ref) {
  return true;
});

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(authStateProvider.state).state;
    return SafeArea(
      child: Scaffold(
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            !ResponsiveLayout.isMobile
                ? Expanded(
                    child: Container(
                        color: const Color(0xff40667D),
                        child: Center(
                          child: SizedBox(
                            height: 700.sh(),
                            width: 700.sw(),
                            child: formState ? Login() : const ForgotPassword(),
                          ),
                        )),
                  )
                : formState
                    ? Login()
                    : const ForgotPassword(),
          ],
        ),
      ),
    );
  }
}
